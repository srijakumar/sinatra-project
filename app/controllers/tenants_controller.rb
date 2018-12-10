class TenantsController < ApplicationController

get '/tenants/:slug' do
  @tenant = Tenant.find_by_slug(params[:slugs])
  erb :'tenants/show'
end

get '/signup' do
    if !logged_in?
      erb :'tenants/new_tenant'
    else
      redirect to '/requests'
    end
  end

post '/signup' do
  if params[:username] == "" || params[:email] == "" || params[:password] == ""
    redirect to '/signup'
  else
    @tenant = Tenant.new(:username => params[:username], :email => params[:email], :password => params[:password])
    @tenant.save
    session[:tenant_id] = @tenant.id
    redirect to '/requests'
  end
end

get '/login' do
  if !logged_in?
    erb :'tenants/login'
  else
    redirect to '/requests'
  end
end

post '/login' do
  tenant = Tenant.find_by(:username => params[:username])
  if tenant && tenant.authenticate(params[:password])
    session[:tenant_id] = tenant.id
    redirect to '/requests'
  else
    redirect to '/signup'
  end
end

get '/logout' do
  if logged_in?
    session.destroy
    redirect to '/login'
  else
    redirect '/'
  end
end

end
