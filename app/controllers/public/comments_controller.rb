class Public::CommentsController < ApplicationController
  
  before_action :authenticate_contributor!

  # コメント作成
  def create
    @current_contributor = current_contributor
    @post = Post.find(params[:post_id])
    #投稿に紐づいたコメントの作成
    @comment = @post.comments.new(comment_params)
    @comment.contributor_id = current_contributor.id
    #返信コメントの作成
    @comment_reply = @post.comments.new
    if @comment.save
      flash[:notice] = "コメントの投稿に成功しました。"
      render :index
    else
      flash[:notice] = "コメントの投稿に失敗しました。"
      render :index
    end
  end

  # コメントの削除
  def destroy
    @current_contributor = current_contributor
    # 返信フォームに渡しているインスタンス変数の追加
    @post = Post.find(params[:post_id])
    @comment_reply = @post.comments.new
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:notice] = "コメントを削除しました。"
      render :index
    else
      flash[:notice] = "コメント削除に失敗しました。"
      render :index
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:comment_text, :contributor_id, :post_id, :parent_id)
  end

end
