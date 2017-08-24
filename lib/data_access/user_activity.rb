module RunningTrackerDatabase
	attr_reader: :user_id, :active_training_session

	class UserActivity
		class << self
			def retrieve(db, user_id)
				user_activity = db[:user_activity].where(user_id: user_id).first
				fail 'Running session not found' unless user_activity
				UserActivity.new(db, user_activity)
			end

			def create(db, user_id)
				db[:user_activity].insert(user_id: user_id))
				user_id
			end
		end
				
		def initialize(db, data)
			@db = db
			@user_id = data[:user_id]
			@active_training_session = data[:active_training_session]
		end

		def create_training_session
			@db.transaction(rollback: :reraise) do
				@db[:user_activity].where(user_id: user_id).update(active_training_session: training_session_id)}
				training_session_id = TrainingSession.create(@db, user_id: @user_id, start_time: Time.now)

				@active_training_session = training_session_id
			end

			@active_training_session
		end
	end
end