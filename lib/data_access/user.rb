require_relative 'user_activity'

module RunningTrackerDatabase
  class User
    attr_reader :user_id, :email, :name, :lastname, :birthdate, :weight, :height

    class << self
      def retrieve_user(db, user_id)
        user = db[:user].where(user_id: user_id).first
        fail 'User not found' unless user
        User.new(db, user)
      end

      def create(db, data)
        user_id = generate_unique_id

        data[:user_id] = user_id
        
        db.transaction(rollback: :reraise) do
          db[:user].insert(data)
          UserActivity.create(db, user_id)
        end

        user_id
      end
    end 

    def initialize(db, data)
      @db = db

      @user_id = data[:user_id]
      @email = data[:email]
      @name = data[:name]
      @lastname = data[:lastname]
      @birthdate = data[:birthdate]
      @weight = data[:weight]
      @height = data[:height]
    end

    def to_h
      {
        user_id: @user_id,
        email: @email,
        name: @name,
        lastname: @lastname,
        birthdate: @birthdate.iso8601,
        weight: @weight,
        height: @height
      }
    end
  end
end