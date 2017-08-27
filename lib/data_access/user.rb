require_relative 'user_activity'

module RunningTrackerDatabase
  class User
    attr_reader :user_id, :email, :name, :lastname, :birthday, :weight, :height

    class << self
      def retrieve(db, user_id)
        user = db[:user].where(user_id: user_id).first
        fail 'User not found' unless user
        User.new(db, user)
      end

      def create(db, data)
        user_id = RunningTrackerDatabase.generate_unique_id
        
        db.transaction(rollback: :reraise) do
          db[:user].insert(
            user_id: user_id,
            email: data[:email],
            name: data[:name],
            lastname: data[:lastname],
            birthday: data[:birthday],
            weight: data[:weight],
            height: data[:height]
          )

          UserActivity.create(db, user_id)
          
          Login.create(db,
            user_id: user_id,
            email: data[:email],
            password: data[:password]
          )
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
      @birthday = data[:birthday]
      @weight = data[:weight]
      @height = data[:height]
    end

    def to_h
      {
        user_id: @user_id,
        email: @email,
        name: @name,
        lastname: @lastname,
        birthday: @birthday.iso8601,
        weight: @weight,
        height: @height
      }
    end
  end
end