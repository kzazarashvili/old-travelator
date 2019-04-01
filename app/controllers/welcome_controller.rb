class WelcomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    # @user = User.find(params[:id])
  end
end
