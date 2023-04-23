class Admin::GenresController < ApplicationController
  
  def index
    # ジャンル作成
    @genre = Genre.new
    # ジャンル一覧
    @genres = Genre.all
  end
  # ジャンル作成
  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "ジャンルを追加しました。"
      redirect_back(fallback_location: admin_genres_path)
    else
      @genres = Genre.all
      render :index
    end
  end
  # ジャンル編集
  def edit
    @genre = Genre.find(params[:id])
  end
  # ジャンル更新
  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "ジャンルを更新しました。"
      redirect_to admin_genres_path
    else
      @genres = Genre.all
      render :index
    end
  end
  # ジャンル削除
  def destroy
    @genre =Genre.find(params[:id])
    if @genre.destroy
      flash[:notice] = "ジャンルを削除しました。"
      redirect_to admin_genres_path
    else
      @genres = Genre.all
      render :index
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
