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

    validates :password, length: { minimum: 6 }, allow_nil: true

    attr_reader :password

    def self.find_by_credentials(email, password)
        @user = User.find_by(email: email)
        if @user && @user.is_password?(password)
            @user
        else
            nil
        end
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password
    end

    def reset_session_token
        self.session_token = User.generate_unique_session_token
        self.save!
        self.session_token
    end


    private

    def self.generate_unique_session_token
        loop do
            session_token = SecureRandom::urlsafe_base64(16)  #16 characters, which is also the default
            if !User.exists?(session_token: session_token)
                return session_token
            end
        end
    end

    def ensure_session_token
        self.session_token ||= User.generate_unique_session_token
    end


end
