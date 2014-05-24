class ProfileController < ApplicationController
    before_filter :authenticate_user!, :user!
    before_action :set_posts, only: [:index, :all_posts]

    def index
      
    end

    def all_posts

    end

    def draft  
      @posts = current_user.posts.where(life_cycle:"draft")
    end

    def new_posts
      @posts = current_user.posts.where(life_cycle:"new_post")
    end

    def publish
      @posts = current_user.posts.where(life_cycle:"publish")
    end

    def archive
      @posts = current_user.posts.where(life_cycle:"archive")
    end

    def transaction
      @post = current_user.posts.find_by(post_params)
      if @post.life_cycle == 'draft'
        @post.go_to_new
        redirect_to profile_path, notice: 'Status update.' and return
      end
      if @post.life_cycle == 'new_post' || 'archive'
        @post.go_to_draft
        redirect_to profile_path, notice: 'Status update.' and return
      end
    end

  private
    def set_posts
      @posts = current_user.posts
    end

    def post_params
        params.require(:post).permit(:id,:life_cycle)
    end

    def user!
      redirect_to root_path, notice: 'Не имеете права доступа!' unless current_user.role.user?
    end

end
