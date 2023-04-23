class Public::HomesController < ApplicationController
  def top
    @contributor = Contributor.find_by(id: params[:id])
    @genres = Genre.all
    # 公開を選択した投稿のみを表示（新着順）includesでプリロードする
    @posts = Post.where(status: :published).order(created_at: :desc).includes(:genre, :tags).page(params[:page]).per(6)
  end

  def about
  end
end
