class Api::V1::UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    skip_before_action :verify_authentication, only: [:index, :show, :create]

    def index
        @users = User.all
        render 'index.json'
    end

    def show
        render 'show.json'
    end

    def create
        @wuser = User.new(user_params)
        if @user.save
            render json: @user, status: :created
        else
            render json: @user.errors, status: :unprocessable_entity
        end
    end

    def update
    end

    def destroy
        @user.destroy
        respond_to :html, :json        
    end

private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
    end

end