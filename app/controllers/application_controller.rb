class ApplicationController < ActionController::Base
  before_filter :set_token

  protect_from_forgery with: :exception

  protected

  def set_token
    RequestStore.store[:token] = ''
  end
end
