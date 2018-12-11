class RequestsController < ApplicationController
  require 'pry'

get '/requests' do
  if logged_in?
    @requests = Request.all
    erb :'requests/requests'
  else
    redirect to '/login'
end
end

get '/requests/new' do
  if logged_in?
    erb :'requests/create_request'
  else
    redirect to '/login'
  end
end

post '/requests' do

  #binding.pry
  if logged_in?
    if params["content"] == ""
      redirect '/requests/new'
    else
      @ticket=Request.new(:content => params[:content], :tenant_id => current_tenant.id, :apt_num => params[:apt_num], :date => params[:date])

    if @ticket.save
     redirect to "/requests/#{@ticket.id}"
    else
      redirect to '/requests/new'
    end

  end
  redirect to '/login'
end
end

get '/requests/:id' do
  if logged_in?
    @ticket = Request.find_by_id(params[:id])
    erb :'requests/show_requests'
  else
    redirect to '/login'
  end
end

get '/requests/:id/edit' do
  if logged_in?
    @ticket = Request.find_by_id(params[:id])
    if @ticket && @ticket.tenant == current_tenant
      erb :'requests/edit_request'
    else
      redirect to '/requests'
    end
  else
    redirect to '/login'
  end
end

patch '/requests/:id' do
  if logged_in?
    if params[:content] ==""
      redirect to "/requests/#{params[:id]}/edit"
    else
      @ticket = Request.find_by_id(params[:id])
      if @ticket && @ticket.tenant == current_tenant
        if @ticket.update(content: params[:content])
          redirect to "/requests/#{@ticket.id}"
        else
          redirect to "/requests/#{@ticket.id}/edit"
        end
      else
        redirect to '/requests'
      end
    end
  else
    redirect '/login'
  end
end


delete '/requests/:id/delete' do
  if logged_in?
    @ticket = Request.find_by_id(params[:id])

    if @ticket && @ticket.tenant == current_tenant
      @request.delete
    end
    redirect to '/requests'
  else
      redirect to '/login'
  end
end

end
