class RequestsController < ApplicationController
  require 'pry'

get '/request' do
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
      @request=Request.new(:content => params["content"], :tenant_id => current_tenant.id, :apt_num => params["apt_num"], :date => params["date"])

    if @request.save
     redirect to "/requests/#{@request.id}"
    else
      redirect to '/requests/new'
    end

  end
  redirect to '/login'
end
end

get '/requests/:id' do
  if logged_in?
    @request = Request.find_by_id(params[:id])
    erb :'requests/show_requests'
  else
    redirect to '/login'
  end
end

get '/requests/:id/edit' do
  if logged_in?
    @request = Request.find_by_id(params[:id])
    if @request && @request.tenant == current_tenant
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
      @request = Request.find_by_id(params[:id])
      if @request && @request.tenant == current_tenant
        if @request.update(content: params[:content])
          redirect to "/requests/#{@request.id}"
        else
          redirect to "/requests/#{@request.id}/edit"
        end
      else
        redirect to '/tweets'
      end
    end
  else
    redirect '/login'
  end
end


end
