require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  def after_sign_in_path_for(resource)
    posts_path
  end
end
