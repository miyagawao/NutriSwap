class Public::HomesController < ApplicationController
  def top
    if params[:id].present?
      @contributor = Contributor.find_by(id: params[:id])
    end
      @genres = Genre.all
    if params[:id].present?
      @contributor = Contributor.find_by(id: params[:id])
    end
  
    @posts = Post.order(created_at: :desc).includes(:genre, :tags).page(params[:page]).per(9)
    if params[:genre_id].present? && params[:tag_id].present?
      @posts = Post.search_genre(params[:genre_id]).search_tag(params[:tag_id]).order(created_at: :desc).page(params[:page]).per(9)
      @title = "タグ:#{params[:tag_id]} / #{params[:genre_name]}"
      @add_posts_title = @posts.first.title if @posts.present?
    elsif params[:genre_id].present?
      @posts = Post.search_genre(params[:genre_id]).order(created_at: :desc).page(params[:page]).per(9)
      @title = params[:genre_name]
      @add_posts_title = @posts.first.title if @posts.present?
    elsif params[:tag_id].present?
      @posts = Post.search_tag(params[:tag_id]).order(created_at: :desc).page(params[:page]).per(9)
      @title = "タグ:#{params[:tag_id]}"
      @add_posts_title = @posts.first.title if @posts.present?
    else
      @posts = Post.order(created_at: :desc).page(params[:page]).per(9)
    end
  end

  def about
  end
end
