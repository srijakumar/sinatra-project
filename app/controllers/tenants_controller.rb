class TenantsController < ApplicationController

get '/tenants/:slug' do
  if logged_in?
    @tenant = Tenant.find_by_slug(params[:slug])
    erb :'tenants/show'
  end
   redirect to '/signup'
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
    #flash[:error] = "All fields are required."
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
    redirect to "/tenants/#{current_tenant.slug(:username)}"
  end
end




post '/login' do
  tenant = Tenant.find_by(email: params[:email])
  #binding.pry
  if tenant && tenant.authenticate(params[:password])
    session[:tenant_id] = tenant.id #logging in
    redirect to "/tenants/#{tenant.slug}"
  else
    #flash[:error] = "Your username or password is incorrect."
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
