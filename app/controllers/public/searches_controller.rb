class Public::SearchesController < ApplicationController
  
  def search
    @range = params[:range]
    
    if @range == 'Post'
      @posts = Post.looks(params[:search], params[:word])
    else
      @contributors = Contributor.looks(params[:search], params[:word])
    end
  end  
end
