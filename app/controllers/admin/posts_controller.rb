class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  # 投稿一覧　新着順　１ページ１５件
  def index
    @posts = Post.order(created_at: :desc).page(params[:page]).per(15)
  end
  # 投稿詳細
  def show
    @post = Post.find(params[:id])
  end
  # 投稿
  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "投稿を削除しました。"
      redirect_to admin_root_path
    else
      flash[:notice] = "投稿の削除に失敗しました。"
      render :show
    end
  end
end
