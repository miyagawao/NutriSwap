class Public::PostsController < ApplicationController
  # sign_inしていない人も投稿一覧画面は閲覧可能
  before_action :authenticate_contributor!, except: [:index]
  # sign_inしているcontributouのみ閲覧・編集可能
  before_action :ensure_current_contributor, only: [:edit, :update, :destroy]
  # 以下アクション呼び出し前にジャンルとタグを取得する
  before_action :set_genres, :tags, only: [:index, :new, :edit]

  # 投稿一覧ページ
  def index
    @current_contributor = current_contributor
    # 公開を選択した投稿のみを表示（新着順）includesでプリロードする
    @posts = Post.where(status: :published).includes(:genre, :tags).order(created_at: :desc).page(params[:page]).per(9)
    # ジャンルとタグの両方が存在する場合
    if params[:genre_id].present? && params[:tag_id].present?
      # ジャンルとタグの両方が指定された場合
      @posts = @posts.search_genre(params[:genre_id]).search_tag(params[:tag_id])
    elsif params[:genre_id].present?
      # ジャンルのみが指定された場合
      @posts = @posts.search_genre(params[:genre_id])
    elsif params[:tag_id].present?
      # タグのみが指定された場合
      @posts = @posts.search_tag(params[:tag_id])
    end
    @posts = @posts.page(params[:page]).per(9)
  end

  # 投稿詳細ページ
  def show
    @post = Post.find(params[:id])
    # 公開投稿または現在のcontributorの下書きの場合に表示
    if @post.status == 'published' || (current_contributor && current_contributor == @post.contributor)
      @current_contributor = current_contributor
      # セッションIDが同じである閲覧は、1回の閲覧としてカウント
      impressionist(@post, nil, unique: [:session_hash])
      # コメント一覧表示で使用する全コメントデータを代入（新着順で表示）
      @comments = @post.comments.order(created_at: :desc)
      # コメントの作成
      @comment = Comment.new
      # 返信コメントの作成
      @comment_reply = @post.comments.new
      @genres = Genre.all
    else
      # 他人の下書きの場合はリダイレクト
      flash[:notice] = "この投稿は表示できません。"
      redirect_to root_path
    end
  end

  # 投稿ページ
  def new
    @post = Post.new
  end
  # 投稿作成
  def create
    @post = current_contributor.posts.new(post_params)
    # 投稿に紐づくタグをフォームから送信されたパラメータから取得する
    tag_list = params[:post][:tag_list].split(',')
    if @post.save
      @post.save_tags(tag_list)
      flash[:notice] = "投稿できました。"
      redirect_to post_path(@post.id)
    else
      flash[:notice] = "投稿に失敗しました。"
      render :new
    end
  end

  # 投稿編集ページ
  def edit
    @post = Post.find(params[:id])
    if current_contributor && current_contributor == @post.contributor
      @post.tag_list = @post.tags.map(&:name).join(', ')
    else
      flash[:notice] = "この投稿は編集できません。"
      redirect_to root_path
    end
  end
  # 投稿の更新
  def update
    @post = Post.find(params[:id])
    # タグリストを更新
    tag_list = params[:post][:tag_list].split(',')
    if @post.update(post_params)
      @post.save_tags(tag_list)
      flash[:notice] = "投稿を更新しました。"
      redirect_to post_path(@post.id)
    else
      flash[:notice] = "投稿の更新に失敗しました。"
      render :edit
    end
  end
  # 投稿の削除
  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "投稿を削除しました。"
      redirect_to posts_path
    else
      flash[:notice] = "投稿の削除に失敗しました。"
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :image, :tag_list, :genre_id, :status)
  end

  def ensure_current_contributor
    @post = Post.find(params[:id])
  end

  def set_genres
    @genres = Genre.all
  end

  def tags
    @tags = Tag.all
  end

end
