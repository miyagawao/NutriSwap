class Public::PostsController < ApplicationController
  # sign_inしていない人も投稿一覧画面は閲覧可能
  before_action :authenticate_contributor!, except: [:index]
  # sign_inしているcontributouのみ閲覧・編集可能
  before_action :ensure_current_contributor, only: [:edit, :update, :destroy]
  before_action :set_genres, :tags, only: [:index, :new, :edit]
  
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
    # コメント一覧表示で使用する全コメントデータを代入（新着順で表示）
    @comments = @post.comments.order(create_at: :desc)
    # コメントの作成
    @comment = Comment.new
    # 返信コメントの作成
    @comment_reply = @post.comments.new
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
    tag_list = params[:post][:tag_list].split(',') # タグリストを更新
  
    # 変更点：タグの更新が成功した場合のみ、タグリストを保存する
    if @post.update(post_params)
      @post.save_tags(tag_list) # 更新したタグリストを保存
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
      redirect_to posts_path
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :image, :tag_list, :genre_id)
  end
  
  def ensure_current_contributor
    @post = Post.find(params[:id])
    unless current_contributor.id == @post.contributor_id
      redirect_to root_path, alert: '権限がありません'
    end
  end

  def set_genres
    @genres = Genre.all
  end

  def tags
    @tags = Tag.all
  end

end
