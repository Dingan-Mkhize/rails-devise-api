class ApplicationController < ActionController::API
   before_action :authenticate_user!, except: [:new, :create]
end
