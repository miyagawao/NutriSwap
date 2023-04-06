class Contributors::SessionsController < Devise::SessionsController
  def guest_sign_in
    contributor = Contributor.guest
    sign_in contributor
    redirect_to contributor_path(contributor), notice: 'ゲストユーザーとしてログインしました。'
  end
end