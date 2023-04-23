class Public::ContributorsController < ApplicationController
  # sign_inしているcontributouのみ閲覧・編集可能
  before_action :ensure_current_contributor

  # 会員詳細ページ
  def show
    @contributor = Contributor.find(params[:id])
    # 投稿（公開）を新着順で表示　１ページ6件の表示
    @posts = @contributor.posts.where(status: :published).order(created_at: :desc).includes(:genre, :tags).page(params[:page]).per(6)
    # ジャンルとタグの両方が存在する場合
    if params[:genre_id].present? && params[:tag_id].present?
      @posts = Post.search_genre(params[:genre_id]).search_tag(params[:tag_id]).order(created_at: :desc).page(params[:page]).per(6)
    # ジャンルのみ存在する場合（タグなし）
    elsif params[:genre_id].present?
      @posts = Post.search_genre(params[:genre_id]).order(created_at: :desc).page(params[:page]).per(6)
    end
    @genres = Genre.all
  end

  # 下書き一覧ページ
  def confirm
    @contributor = Contributor.find(params[:id])
    # 下書き保存の投稿のみ新着順で表示　１ページ９件
    @posts = @contributor.posts.where(status: :draft).order('created_at DESC').page(params[:page]).per(9)
    # ジャンルとタグが存在する場合
    if params[:genre_id].present? && params[:tag_id].present?
      @posts = Post.search_genre(params[:genre_id]).search_tag(params[:tag_id]).order(created_at: :desc).page(params[:page]).per(6)
    # ジャンルのみ存在する場合（タグなし）
    elsif params[:genre_id].present?
      @posts = Post.search_genre(params[:genre_id]).order(created_at: :desc).page(params[:page]).per(6)
    end
    @genres = Genre.all
  end

  # 会員情報編集ページ
  def edit
    @contributor = Contributor.find(current_contributor.id)
  end
  # 会員情報更新
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
    # セッション情報を削除し、ログアウトする
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