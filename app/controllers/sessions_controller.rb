class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[new create]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
    # Render login form (if any additional logic needed, can be added here)
  end

  def create
    # Use Devise's built-in method to authenticate the user
    user = User.find_for_database_authentication(email: params[:email_address])

    if user&.valid_password?(params[:password])
      reset_session
      start_new_session_for user
      redirect_to after_authentication_url
    else
      redirect_to new_session_path, alert: "Invalid email or password"
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path
  end
end
