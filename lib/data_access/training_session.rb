require_relative 'running_session'

module RunningTrackerDatabase
  class TrainingSession
    attr_reader: :user_id, :training_session_id, :start_time, :end_time, :active_session_id

    class << self
      def retrieve(db, training_session_id)
        training_session = db[:training_session].where(training_session_id: training_session_id).first
        fail 'Running session not found' unless training_session
        RunningSession.new(db, training_session)
      end

      def create(db, data)
        training_session_id = generate_unique_id
        data[:training_session_id] = training_session_id
        db[:training_session].insert(data)a)
        training_session_id
      end
    end 

    def initialize(db, data)
      @db = db

      @training_session_id = user[:training_session_id]
      @user_id = user[:user_id]
      @start_time = user[:start_time]
      @end_time = user[:end_time]
      @active_session_id = user[:active_session_id]
    end

    def to_h
      {
        user_id: @user_id,
        training_session_id: @training_session_id
        start_time: @start_time.iso8601
        end_time: @end_time.iso8601
        active_session_id: @active_session_id
      }
    end

    def create_running_session
      @db.transaction(rollback: :reraise) do
        @db[:training_session].where(training_session_id: @training_session_id).update(active_session_id: running_session_id)}
        running_session_id = RunningSession.create(@db, training_session_id: @training_session_id, start_time: @start_time)

        @active_session_id = running_session_id
      end

      @active_session_id
    end
  end
end