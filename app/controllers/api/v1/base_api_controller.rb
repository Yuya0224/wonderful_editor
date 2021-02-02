class Api::V1::BaseApiController < ApplicationController
  # ダミーのcurrent_userを作る
  def dummy
    # binding.pry
    @current_user ||= User.first
  end
end

# current_user
