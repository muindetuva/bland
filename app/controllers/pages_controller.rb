class PagesController < ApplicationController
  allow_unauthenticated_access only: [ :home ]
  before_action :require_authentication, only: [ :dashboard ]

  def home
    redirect_to dashboard_path if authenticated?
  end
  def dashboard
  end
end
