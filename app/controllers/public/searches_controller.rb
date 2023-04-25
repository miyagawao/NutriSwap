class Public::SearchesController < ApplicationController
  
  def search
    @range = params[:range]
    # 投稿を検索した場合
    if @range == 'Post'
      @posts = Post.looks(params[:search], params[:word]).order(created_at: :desc).page(params[:page]).per(9)
    # 投稿者を検索した場合
    else
      @contributors = Contributor.looks(params[:search], params[:word]).order(created_at: :desc).page(params[:page]).per(9)
    end
    @genres = Genre.all
  end
end
