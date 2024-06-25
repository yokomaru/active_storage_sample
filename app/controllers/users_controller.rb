class UsersController < ApplicationController
  def index
    @users = User.with_attached_avatar.order('created_at DESC')
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_url, notice: 'Add User'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to root_url, notice: 'Update User'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.fetch(:user, {}).permit(:name, :avatar)
  end
end
