class RequestsController < ApplicationController

get '/request' do
  if logged_in?
    @requests = Request.all
    erb :'requests/requests'
  else
    redirect to '/login'
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

end
