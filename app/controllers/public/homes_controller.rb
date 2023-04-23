class Public::HomesController < ApplicationController
  def top
    @contributor = Contributor.find_by(id: params[:id])
    @genres = Genre.all
    # 公開を選択した投稿のみを表示（新着順）includesでプリロードする
    @posts = Post.where(status: :published).order(created_at: :desc).includes(:genre, :tags).page(params[:page]).per(9)
    # ジャンルとタグの両方が存在する場合
    if params[:genre_id].present? && params[:tag_id].present?
      @posts = Post.search_genre(params[:genre_id]).search_tag(params[:tag_id]).order(created_at: :desc).page(params[:page]).per(6)
    # ジャンルのみ存在する場合（タグなし）
    elsif params[:genre_id].present?
      @posts = Post.search_genre(params[:genre_id]).order(created_at: :desc).page(params[:page]).per(6)
    end
  end

  def about
  end
end
