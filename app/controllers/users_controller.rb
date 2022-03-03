class UsersController < ApplicationController
  before_action :authenticate_user!, :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.paginate(:page => params[:page], :per_page => params[:per_page] ||= 30).order(created_at: :desc)
  end

  # GET /users/1 or /users/1.json
  def show
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to action: :index
      flash[:alert] = "The requested user was not found!"
    end

  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.fetch(:user, {})
  end
end
