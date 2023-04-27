class Public::LikesController < ApplicationController
  before_action :set_post
  
  # お気に入り一覧
  def index
    # 現在ログインしているcontributor
    @contributor = current_contributor
    # ログインユーザーがいいねした投稿のIDを取得
    likes = Like.where(contributor_id: current_contributor.id).pluck(:post_id)
    # likes配列内のIDに対応するPostレコードを取得
    @likes_posts = Post.where(id: likes).order(created_at: :desc).includes(:genre, :tags).page(params[:page]).per(9)
    @genres = Genre.all
  end
  
  # いいね作成
  def create
    @post = Post.find(params[:post_id])
    @current_contributor = current_contributor
    # Likeオブジェクトを作成
    @like = Like.create(contributor_id: @current_contributor.id, post_id: params[:post_id])
    # 投稿に対するすべてのいいねを検索
    @likes = Like.where(post_id: params[:post_id])
    @post.reload
  end

  def destroy
    @post = Post.find(params[:post_id])
    @current_contributor = current_contributor
    # ログインユーザーがいいねを押しているか確認する
    like = Like.find_by(contributor_id: @current_contributor.id, post_id: params[:post_id])
    like.destroy
    # この投稿に対するすべてのいいねを取得
    @likes = Like.where(post_id: params[:post_id])
    @post.reload
  end
  
  private
  
  def set_post
    @post = Post.find(params[:post_id])
  end
  
end
