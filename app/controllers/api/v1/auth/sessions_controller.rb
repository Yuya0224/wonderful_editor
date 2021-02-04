class Api::V1::Auth::SessionsController < DeviseTokenAuth::SessionsController
  # private
  # def current_sign_in_at
  #   params.permit(:created_at)
  # end
end
