class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.order(created_at: :desc).page(params[:page]).per(15)
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "投稿を削除しました。"
      redirect_to admin_root_path
    else
      render :show
    end
  end
end
