# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_request, only: %i[login register]

      # POST /register
      def register
        @user = User.create(user_params)
        if @user.save
          response = { message: 'User created successfully'}
          render json: response, status: :created
        else
          render json: @user.errors, status: :bad
        end
      end

      def login
        authenticate params[:username], params[:password]
      end

      def test
        render json: {
            message: 'You have passed authentication and authorization test'
        }
      end

      def index
        @users = User.select(:id, :name, :email)
        render json: @users, status: :ok
      end

      private

      def authenticate(email, password)
        command = AuthenticateUser.call(email, password)
        if command.success?
          user = User.find_by(email: email)
          render json: {
              access_token: command.result,
              user: { user_id: user.id,
                first_name: user.first_name,
                last_name: user.last_name,
                email: user.email,
                aadhaar: user.aadhaar,
                address: user.address,
                zip_code: user.zip_code
              },
              message: 'Login Successful',
              status: :ok
          }
        else
          render json: { error: command.errors }, status: :unauthorized
        end
      end

      def user_params
        params.permit(
            :first_name,
            :last_name,
            :email,
            :zip_code,
            :password
        )
      end
    end
  end
end
