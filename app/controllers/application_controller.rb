require 'application_responder'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html
  before_action :authenticate_user!
  before_action :load_friend_requests

  def after_sign_in_path_for(_resource)
    posts_path
  end

  private

  def load_friend_requests
    @friend_requests = FriendRequest.where(receiver_id: current_user, status: 'pending')
  end
end
