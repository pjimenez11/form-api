module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user!
      load_and_authorize_resource
      before_action :set_user, only: %i[show destroy]

      def index
        @users = User.all

        @serialize_users = @users.map { |user| serialize_user(user) }

        render json: {
          users: @serialize_users
        }
      end

      def show
        authorize! :read, @user
        render json: {
          user: serialize_user(@user)
        }
      end

      def create
        if params[:user][:company_id].present?
          @user = User.new(user_params)
        else
          @company = Company.new(company_params)
          @user = @company.users.build(user_params)
        end

        if @user.save
          render json: { user: serialize_user(@user) }, status: :created
        else
          render json: { errors: @user.errors.messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if @user.destroy
          head :no_content
        else
          render json: { error: @user.errors.messages }, status: :unprocessable_entity
        end
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :role, :company_id)
      end

      def company_params
        params.require(:user).permit(company_attributes: [:name])
      end

      def serialize_user(user)
        UserSerializer.new.serialize(user).to_json
      end
    end
  end
end
