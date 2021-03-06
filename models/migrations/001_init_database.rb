Sequel.migration do
  transaction

  up do

    create_table(:user) do
      String      :user_id, size: 24, primary_key: true
      String      :email, size: 50, null: false, unique: true, index: true
      String      :name, size: 50, null: false
      String      :lastname, size: 50, null: false
      DateTime    :birthday, null: false
      Float       :weight
      Float       :height
    end

    create_table(:user_stats) do
      String      :user_id, size: 24, primary_key: true
      String      :user_stats, size: 20, null: false, index: true
      Float       :value, null: false
    end

    create_table(:user_activity) do
      String      :user_id, size: 24, primary_key: true
      String      :active_training_session_id, size: 24, null: true, index: true
    end

    create_table(:training_session) do
      String      :training_session_id, size: 24, primary_key: true
      String      :user_id, size: 24, index: true

      DateTime    :start_time, null: false, default: Time.now
      DateTime    :end_time
      String      :active_session_id, size: 24, index: true
    end

    create_table(:running_session) do
      Integer     :running_session_id, primary_key: true, auto_increment: true
      String      :training_session_id, size: 24, index: true

      DateTime    :start_time, null: false, default: Time.now
      DateTime    :end_time
      Float       :distance, default: 0
    end

    create_table(:login) do
      String      :email, size: 50, primary_key: true
      String      :user_id, size: 24, unique: true, index: true, null: false
      String      :password, size: 30, index: true, null: false
    end
  end
end