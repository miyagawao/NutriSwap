class Public::ReportsController < ApplicationController
  before_action :set_comment
  
  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    @report.reporter_id = current_contributor.id
    if @report.save
      flash[:notice] = "ご報告ありがとうございました。"
      redirect_to post_path(@comment)
    else
      render "new"
    end
  end
  
  private
  
  def set_comment
    @comment = Comment.find(params[:comment_id])
  end
  
  def report_params
    params.require(:report).permit(:reason)
  end
  
end
