class Public::ContributorsController < ApplicationController
  # sign_inしているcontributouのみ閲覧・編集可能
  before_action :ensure_current_contributor

  def show
    @contributor = Contributor.find(params[:id])
    @posts = @contributor.posts.order(created_at: :desc).includes(:genre, :tags).page(params[:page]).per(8)
    if params[:genre_id].present? && params[:tag_id].present?
      @posts = Post.search_genre(params[:genre_id]).search_tag(params[:tag_id]).order(created_at: :desc).page(params[:page]).per(8)
      @title = "タグ:#{params[:tag_id]} / #{params[:genre_name]}"
      @add_posts_title = @posts.first.title if @posts.present?
    elsif params[:genre_id].present?
      @posts = Post.search_genre(params[:genre_id]).order(created_at: :desc).page(params[:page]).per(8)
      @title = params[:genre_name]
      @add_posts_title = @posts.first.title if @posts.present?
    elsif params[:tag_id].present?
      @posts = Post.search_tag(params[:tag_id]).order(created_at: :desc).page(params[:page]).per(8)
      @title = "タグ:#{params[:tag_id]}"
      @add_posts_title = @posts.first.title if @posts.present?
    else
      @posts = Post.order(created_at: :desc).page(params[:page]).per(8)
    end
    @genres = Genre.all
  end

  def edit
    @contributor = Contributor.find(current_contributor.id)
  end

  def update
    @contributor = Contributor.find(current_contributor.id)
    if @contributor.update(contributor_params)
      flash[:notice] = "変更を保存しました。"
      redirect_to contributor_path(@contributor)
    else
      render :edit
    end
  end
  # 退会画面
  def unsubscribe
    @contributor = Contributor.find(current_contributor.id)
  end

  #退会処理
  def withdrawal
    @contributor = Contributor.find(current_contributor.id)
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @contributor.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会が完了しました。ご利用ありがとうございました。"
    redirect_to new_contributor_session_path
  end
  
  
  private

  def contributor_params
    params.require(:contributor).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :nickname, :email, :postal_code, :address, :telephone_number, :qualification, :profile_image, :introduce, :is_deleted)
  end

  def ensure_current_contributor
    if !contributor_signed_in?
      #ログイン/未ログインの処理 未ログインならトップへ
      redirect_to root_path
    end
  end
end