class Admin::ReportsController < ApplicationController
  # 通報一覧
  def index
    # 通報されたコメント
    @comment = Comment.find(params[:comment_id])
    @reports = @comment.reports
  end

end
