class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

   # Redirect after sign in
   def after_sign_in_path_for(resource)
    events_path
  end

  # Redirect after sign up
  def after_sign_up_path_for(resource)
    events_path
  end
end
