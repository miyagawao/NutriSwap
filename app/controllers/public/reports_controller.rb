class Public::ReportsController < ApplicationController

  def new
    @comment = Comment.find(params[:comment_id])
    @report = Report.new
  end

  def create
    @post = Comment.find(params[:comment_id]).post
    @comment = Comment.find(params[:comment_id])
    @contributor = Contributor.find(params[:contributor_id])
    @reporter = current_contributor
    @report = Report.new(report_params)
    @report.comment = @comment
    @report.contributor = @contributor
    @report.reporter = @reporter
    if @report.save!
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
