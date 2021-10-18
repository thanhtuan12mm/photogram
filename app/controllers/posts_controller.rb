class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :authenticate_user!
  before_action :owned_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.order('created_at DESC').page params[:page]
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:info] = "Your post has been created successfully!"
      redirect_to posts_path
    else
      flash.now[:alert] = 'Your new post could not be created! Please check the form!'
      render :new
    end
  end

  def show
  end

  def edit
  end

  def like
    if @post.liked_by current_user
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end

  def unlike
    if @post.unliked_by current_user
      respond_to do |format|
        format.js
        format.html { redirect_to :back }
      end
    end
  end

  def update
    if @post.update(post_params)
      flash[:success] = 'Post edited!'
      redirect_to post_path(@post)
    else 
      flash.now[:alert] = 'Update failed! Please check the form!'
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:danger] = 'Post deleted!'
    redirect_to posts_path
  end

  private
  def owned_post
    unless current_user == @post.user
      flash[:danger] = "That post doesn't belong to you!"
      redirect_to root_path
    end
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:image, :caption)
  end
end
