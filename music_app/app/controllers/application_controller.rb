class ApplicationController < ActionController::Base

    private

    def current_user
        return nil if !session[:session_token]
        @current_user ||= User.find_by(session_token: session[:session_token])
    end
end
