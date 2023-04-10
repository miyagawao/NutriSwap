class Public::HomesController < ApplicationController
  def top
    if params[:id].present?
      @contributor = Contributor.find_by(id: params[:id])
    end
    
    @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
    if params[:genre_id].present? && params[:tag_id].present?
      @posts = Post.search_genre(params[:genre_id]).search_tag(params[:tag_id]).page(params[:page]).per(8)
      @title = "タグ:#{params[:tag_id]} / #{params[:genre_name]}"
      @add_posts_title = @posts.first.title if @posts.present?
    elsif params[:genre_id].present?
      @posts = Post.search_genre(params[:genre_id]).page(params[:page]).per(8)
      @title = params[:genre_name]
      @add_posts_title = @posts.first.title if @posts.present?
    elsif params[:tag_id].present?
      @posts = Post.search_tag(params[:tag_id]).page(params[:page]).per(8)
      @title = "タグ:#{params[:tag_id]}"
      @add_posts_title = @posts.first.title if @posts.present?
    else
      @posts = Post.page(params[:page]).per(8)
    end
  end

  def about
  end
end
