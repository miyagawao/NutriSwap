class Public::PostsController < ApplicationController
  def index
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

  def show
    @post = Post.find(params[:id])
    @contributor = @post.contributor
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_contributor.posts.new(post_params)
    tag_list = params[:post][:tag_list].split(',')
    if @post.save
      @post.save_tags(tag_list)
      flash[:success] = "投稿できました。"
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update
      flash[:notice] = "編集を保存しました。"
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "投稿を削除しました。"
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :image, :tag_list, :genre_id)
  end

  def set_genres
    @genres = Genre.all
  end

  def tags
    @tags = Tag.all
  end

end
