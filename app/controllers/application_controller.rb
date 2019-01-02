require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "app_secret"
    use Rack::Flash, :sweep => true
  end

  get "/" do
    erb :welcome
  end

  helpers do

   def logged_in?
     !!current_tenant
   end

   def current_tenant
     @current_tenant ||= Tenant.find_by(id: session[:tenant_id]) if session[:tenant_id]
   end
end

end
