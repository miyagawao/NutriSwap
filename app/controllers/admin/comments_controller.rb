class Admin::CommentsController < ApplicationController
  def index
    @comments = Comment.order(created_at: :desc)
  end

  def show
    @comment = Comment.find(params[:id])
  end

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
