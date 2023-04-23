class Admin::CommentsController < ApplicationController
  # コメント一覧（新着順）
  def index
    @comments = Comment.order(created_at: :desc)
  end
  # コメント詳細
  def show
    @comment = Comment.find(params[:id])
  end
  # コメント削除
  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:notice] = "コメントを削除しました。"
      redirect_to admin_comments_path
    else
      flash[:notice] = "コメント削除に失敗しました。"
      render :show
    end
  end
end
