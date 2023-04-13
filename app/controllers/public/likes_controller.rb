class Public::LikesController < ApplicationController
  before_action :set_post
  
  def index
    @contributor = current_contributor
    @posts = @contributor.posts.order(created_at: :desc).includes(:genre, :tags).page(params[:page]).per(8)
    likes = Like.where(contributor_id: current_contributor.id).pluck(:post_id)
    @likes_posts = Post.find(likes)
    @genres = Genre.all
  end
  
  def create
    @post = Post.find(params[:post_id])
    @current_contributor = current_contributor
    @like = Like.create(contributor_id: @current_contributor.id, post_id: params[:post_id])
    @likes = Like.where(post_id: params[:post_id])
    @post.reload
  end

  def destroy
    @post = Post.find(params[:post_id])
    @current_contributor = current_contributor
    like = Like.find_by(contributor_id: @current_contributor.id, post_id: params[:post_id])
    like.destroy
    @likes = Like.where(post_id: params[:post_id])
    @post.reload
  end
  
  private
  
  def set_post
    @post = Post.find(params[:post_id])
  end
  
end
