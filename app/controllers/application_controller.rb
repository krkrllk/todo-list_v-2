class ApplicationController < ActionController::Base
  include Authentication
  
  # Explicitly list actions where you don't need authentication, e.g., 'new' and 'create' for login
  before_action :authenticate_user!, unless: :public_action?

  def after_sign_in_path_for(resource)
    tasks_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  helper :all  # Make helpers available to views

  private

  # Determine if the action is public (i.e., no authentication needed)
  def public_action?
    controller_name == 'sessions' && ['new', 'create'].include?(action_name)
  end
end
