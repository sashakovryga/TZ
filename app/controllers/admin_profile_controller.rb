class AdminProfileController < ApplicationController
  before_filter :authenticate_user!, :admin!

  def index
    @users = User.all.paginate(page: params[:page])
  end

  def all_posts
    @posts = Post.where.not(life_cycle: "draft").paginate(page: params[:page])
  end

  def new_posts
    @posts = Post.where(life_cycle: "new_post").paginate(page: params[:page])
  end

  def publish
    @posts = Post.where(life_cycle: "publish").paginate(page: params[:page])
  end

  def archive
    @posts = Post.where(life_cycle: "archive").paginate(page: params[:page])
  end

  def transaction
    @post = Post.find_by(post_params)
    @post.go_to_draft if @post.life_cycle == 'new_post'
    redirect_to admin_profile_path, notice: 'Status update.'
  end

  def transaction_for_approved
    @post = Post.find_by(post_params)
    @post.good_post if @post.life_cycle == 'new_post'
    redirect_to admin_profile_path, notice: 'Status update.'
  end

private

  def post_params
    params.require(:post).permit(:id, :life_cycle)
  end

  def admin!
    redirect_to root_path, notice: 'Не имеете права доступа!' unless current_user.role.admin?
  end
end
