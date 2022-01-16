class Api::V1::UsersController < ApplicationController
  def create
    if params[:password] == params[:password_confirmation]
      user = User.create!(user_params)
      render json: UserSerializer.new(user), status: 201
    else
      render json: {error: "Password and confirmation do not match"}, status: 422
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end