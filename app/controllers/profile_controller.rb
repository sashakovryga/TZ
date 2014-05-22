class ProfileController < ApplicationController
    before_filter :authenticate_user!
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
      @post.go_to_new if @post.life_cycle == 'draft'
      @post.good_post if @post.life_cycle == 'new_post'
      @post.published if @post.life_cycle == 'approved'
      @post.go_to_archive if @post.life_cycle == 'publish'
      @post.go_to_draft if @post.life_cycle == 'new_post' || 'archive'
    end

  private
    def set_posts
      @posts = current_user.posts
    end

    def post_params
        params.require(:post).permit(:id,:life_cycle)
    end

end
