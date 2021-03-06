module RunningTrackerDatabase
  class RunningSession
    attr_reader :running_session_id, :training_session_id, :start_time, :end_time, :distance

    class << self
      def retrieve(db, running_session_id)
        running_session = db[:running_session].where(user_id: user_id).first
        fail 'Running session not found' unless running_session
        RunningSession.new(db, running_session)
      end

      def create(db, data)
        running_session_id = RunningTrackerDatabase.generate_unique_id
        data[:running_session_id] = running_session_id
        db[:running_session].insert(data)
        running_session_id
      end
    end 

    def initialize(db, data)
      @db = db

      @running_session_id = data[:running_session_id]
      @training_session_id = data[:training_session_id]
      @start_time = data[:start_time]
      @end_time = data[:end_time]
      @distance = data[:distance]
    end

    def to_h
      {
        running_session_id: @running_session_id,
        training_session_id: @training_session_id,
        start_time: @start_time.iso8601,
        end_time: @end_time.iso8601,
        distance: @distance
      }
    end
  end
end