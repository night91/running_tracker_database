require 'digest'
require_relative 'user_activity'

module RunningTrackerDatabase
  class Login
    attr_reader: :user_id, :email, :password

    class << self
      def retrieve(db, email)
        login = db[:login].where(email: email).first
        fail 'User not found' unless login
        Login.new(db, login)
      end

      def create(db, data)
        data[:password] = Digest::SHA256.base64digest(data[:password])
        db[:login].insert(data)
      end
    end 

    def initialize(db, data)
      @db = db

      @user_id = user[:user_id]
      @email = user[:email]
      @password = user[:password]
    end

    def to_h
      {
        user_id: @user_id,
        email: @email
        password: @password
      }
    end
  end
end