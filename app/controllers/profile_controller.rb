class ProfileController < ApplicationController
  def index

  end

  def all_posts
    @posts = Post.all
  end

  def draft  
  
  end

  def new_posts

  end

  def publish

  end

  def archive

  end

end
