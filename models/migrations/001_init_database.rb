Sequel.migration do
  transaction

  up do

    create_table(:user) do
      String      :user_id, size: 24, primary_key: true
      String      :email, size: 50, null: false, unique: true, index: true
      String      :name, size: 50, null: false
      String      :lastname, size: 50, null: false
    end

    create_table(:running_session) do
      Integer     :running_session_id, primary_key: true, auto_increment: true
      String      :training_session_id, size: 24, index: true

      DateTime    :start_date
      DateTime    :end_date
      Float       :distance
      Integer     :time_elapsed
    end

    create_table(:user_training_session) do
      String      :user_id, size: 24
      String      :training_session_id, size: 24

      primary_key [:user_id, :training_session_id]
    end
  end
end