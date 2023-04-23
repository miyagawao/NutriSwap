class Public::ReportsController < ApplicationController
  # 通報する
  def new
    @comment = Comment.find(params[:comment_id])
    @report = Report.new
  end

  def create
    # コメントが属する投稿
    @post = Comment.find(params[:comment_id]).post
    # 通報されたコメント
    @comment = Comment.find(params[:comment_id])
    # コメントした利用者
    @contributor = Contributor.find(params[:contributor_id])
    # 通報をした利用者
    @reporter = current_contributor
    @report = Report.new(report_params)
    @report.comment = @comment
    @report.contributor = @contributor
    @report.reporter = @reporter
    if @report.save
      flash[:notice] = "ご報告ありがとうございました。"
      redirect_to post_path(@post.id)
    else
      render "new"
    end
  end

  private

  def report_params
    params.require(:report).permit(:reason)
  end
end
