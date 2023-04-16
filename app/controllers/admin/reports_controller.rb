class Admin::ReportsController < ApplicationController
  def index
    @comment = Comment.find(params[:comment_id])
    @reports = @comment.reports
  end

end
