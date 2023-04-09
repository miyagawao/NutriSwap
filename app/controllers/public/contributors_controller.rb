class Public::ContributorsController < ApplicationController
  before_action :ensure_current_contributor
    #sign_inしているcustomerのみ閲覧・編集可能

  def show
    @contributor = Contributor.find(params[:id])
  end

  def edit
    @contributor = Contributor.find(current_contributor.id)
  end

  def update
    @contributor = Contributor.find(current_contributor.id)
    if @contributor.update(contributor_params)
      flash[:notice] = "変更を保存しました。"
      redirect_to root_path
    else
      render :edit
    end
  end

  def unsubscribe
    @contributor = Contributor.find(current_contributor.id)
  end

  #退会処理
  def withdrawal
    @contributor = Contributor.find(current_contributor.id)
    @contributor.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def contributor_params
    params.require(:contributor).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :nickname, :email, :postal_code, :address, :telephone_number, :qualification, :profile_image, :introduce, :is_deleted)
  end
end

  def ensure_current_contributor
    if !contributor_signed_in?
      #ログイン/未ログインの処理 未ログインならトップへ
      redirect_to root_path
    end
  end