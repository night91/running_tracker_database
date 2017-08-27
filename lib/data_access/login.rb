require 'digest'
require_relative 'user_activity'

module RunningTrackerDatabase
  class Login
    attr_reader :user_id, :email, :password

    class << self
      def retrieve(db, email)
        login = db[:login].where(email: email).first
        fail 'Login does not found' unless login
        Login.new(db, login)
      end

      def create(db, data)
        data[:password] = Digest::SHA256.base64digest(data[:password])
        db[:login].insert(data)
      end

      def authorized?(db, email, password)
        password_hash = Digest::SHA256.base64digest(password)
        login = db[:login].where(email: email, password: password_hash).first
        !login.nil?
      end
    end 

    def initialize(db, data)
      @db = db

      @user_id = data[:user_id]
      @email = data[:email]
      @password = data[:password]
    end

    def to_h
      {
        user_id: @user_id,
        email: @email,
        password: @password
      }
    end
  end
end