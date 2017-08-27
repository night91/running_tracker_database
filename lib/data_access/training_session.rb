require_relative 'running_session'

module RunningTrackerDatabase
  class TrainingSession
    attr_reader :user_id, :training_session_id, :start_time, :end_time, :active_session_id

    class << self
      def retrieve(db, training_session_id)
        training_session = db[:training_session].where(training_session_id: training_session_id).first
        fail 'Running session not found' unless training_session
        RunningSession.new(db, training_session)
      end

      def create(db, data)
        training_session_id = RunningTrackerDatabase.generate_unique_id
        data[:training_session_id] = training_session_id
        db[:training_session].insert(data)
        training_session_id
      end

      def all_training_sessions_by_user_id(db, user_id)
        db[:training_session].where(user_id: user_id).all
      end
    end

    def initialize(db, data)
      @db = db

      @training_session_id = data[:training_session_id]
      @user_id = data[:user_id]
      @start_time = data[:start_time]
      @end_time = data[:end_time]
      @active_session_id = data[:active_session_id]
    end

    def to_h
      {
        user_id: @user_id,
        training_session_id: @training_session_id,
        start_time: @start_time.iso8601,
        end_time: @end_time.iso8601,
        active_session_id: @active_session_id
      }
    end

    def create_running_session
      @db.transaction(rollback: :reraise) do
        @db[:training_session].where(training_session_id: @training_session_id)
                              .update(active_session_id: running_session_id)
        running_session_id = RunningSession.create(@db, training_session_id: @training_session_id, start_time: @start_time)

        @active_session_id = running_session_id
      end

      @active_session_id
    end
  end
end