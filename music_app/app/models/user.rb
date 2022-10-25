# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
    validates :email, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :session_token, uniqueness: true

    def self.find_by_credentials(username, password)
        @user = User.find_by(username: username)
        if @user && @user.is_password?(password)
            @user
        else
            nil
        end
    end

    def is_password?(password)
        
    end
end
