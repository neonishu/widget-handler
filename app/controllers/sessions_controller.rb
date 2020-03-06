# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :user_logged_in?, only: %i[create new]

  def new
    @session = Session.new
  end

  def create
    api_session = Session.new(params.require(:session).permit(:username, :password))
    result = api_session.create
    session[:user_information] = pluck_user_info(result)
    session[:user_information][:email] = params[:session][:username]
    flash[:success] = 'Signed in successfully!'
    redirect_to resolve_landing_path
  rescue RestClient::Unauthorized
    @session = Session.new
    flash.now[:alert] = 'Invalid email or password'
    render :new
  end

  def destroy
    Session.destroy(token: session[:user_information]['access_token'])
    session.delete :user_information
    flash[:success] = 'Signed out successfully'
    redirect_to root_path
  end

  private

  def resolve_landing_path
    params[:return_to] || root_path
  end
end
