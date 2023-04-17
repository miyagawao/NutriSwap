class Admin::GenresController < ApplicationController
  def index
    @genre = Genre.new
    @genres = Genre.all
  end

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

  def edit
    @genre = Genre.find(params[:id])
  end

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
