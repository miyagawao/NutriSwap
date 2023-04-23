class Admin::ContributorsController < ApplicationController
  # 会員一覧
  def index
    @contributors = Contributor.all
  end
  # 会員詳細
  def show
    @contributor = Contributor.find(params[:id])
  end
  # 会員情報編集
  def edit
    @contributor = Contributor.find(params[:id])
  end
  # 会員情報更新
  def update
    @contributor = Contributor.find(params[:id])
    if @contributor.update(contributor_params)
      flash[:notice] = "変更を保存しました。"
      redirect_to admin_contributor_path(@contributor.id)
    else
      render :edit
    end
  end

  private

  def contributor_params
    params.require(:contributor).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :nickname, :email, :postal_code, :address, :telephone_number, :qualification, :profile_image, :introduce, :is_deleted)
  end
end