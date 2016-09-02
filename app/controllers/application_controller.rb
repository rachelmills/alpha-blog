class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in? # will be available to views

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id] # this syntax returns the current user if we have already called current_user, otherwise it will do the find
  end

  def logged_in?
    !!current_user # !! converts to boolean
  end

  def require_user
    if !logged_in?
      flash[:danger] = 'You must be logged in to perform that action'
      redirect_to root_path
    end
  end
end
