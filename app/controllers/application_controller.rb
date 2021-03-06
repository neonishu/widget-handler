# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception

  before_action :set_session_and_user

  after_action :set_cookies

  # Resolves current user.
  def current_user
    @current_user ||= begin
                        if session[:user_information].present?
                          User.new(session[:user_information])
                       end
                      end
  end

  def set_session_and_user
    @user = User.new
    @session = Session.new
  end

  def set_cookies
    session[:user_information] = current_user
  end

  rescue_from RestClient::UnprocessableEntity do
    redirect_to root_path, alert: 'Something is not right, please try again with correct values!!!'
  end

  rescue_from RestClient::Unauthorized do
    redirect_to root_path, alert: 'Something is not right, please try again with correct values!!!'
  end

  helper_method :current_user

  private

  def pluck_user_info(response)
    data = {}
    response = response[:data] if response[:data]
    if response[:user]
      data[:id] = response[:user][:id]
      data[:email] = response[:user][:email]
    end

    if response[:token]
      data[:access_token] = response[:token][:access_token]
      data[:refresh_token] = response[:token][:refresh_token]
      data[:expires_in] = response[:token][:expires_in]
    end

    data
  end

  def user_logged_in?
    redirect_to root_path, notice: 'Logged in already!' if current_user.present?
  end

  def authenticate_user
    if !current_user || current_user.expires_in > DateTime.now.to_i
      redirect_to new_session_path, notice: 'Login first to complete action!'
    end
  end
end
