class AdminProfileController < ApplicationController
  before_action :set_user, only: [:show_user, :edit_user, :update_user, :destroy_user]
  #before_filter :authenticate_user!, except: [:show, :index]
  #load_and_authorize_resource :except => :create

  def index
    @users = User.all
  end

  def show_user
  end

  def new_user
    @user = User.new
  end

  def edit_user
    @user = User.find(params[:id])
  end

  def create_user
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_profile_path, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_user
    respond_to do |format|
      if @user.update(user_params) && @user.life_cycle == 'draft'
        format.html { redirect_to @user, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy_user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to user_url }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(admin_profile_path).permit(:name, :last_name, :email, :password, :role)
    end
end
