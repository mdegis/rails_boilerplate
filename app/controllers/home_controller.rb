class HomeController < ApplicationController
  def index
    render json: { ok: current_user.username }
  end
end
