class UsersController < ApplicationController

    def create
        @user = User.new(user_params)
        # if @user.save

        # else

        # end
    end

    def new
        @user = User.new
        render :new
    end

    private
    def user_params
        params.require(:user).permit(:email, :password, :password_digest, :session_token)
    end
end