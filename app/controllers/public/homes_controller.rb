class Public::HomesController < ApplicationController
  def top
    if params[:id].present?
      @contributor = Contributor.find_by(id: params[:id])
    end
  end

  def about
  end
end
