Sequel.migration do
  transaction

  up do

    create_table(:user) do
      String      :user_id, size: 24, primary_key: true
      String      :email, size: 50, null: false
      String      :name, size: 50, null: false
      String      :lastname, size: 50, null: false
    end

    create_table(:running_session) do
      String      :user_id, size: 24, primary_key: true
      String      :training_session_id, size: 24, primary_key: true
      DateTime    :start_date, null: false
      DateTime    :end_date
      Float       :distance
      Integer     :time_elapsed
    end

    create_table(:trainning_session) do
      String      :user_id, size: 24, primary_key: true
      String      :training_session_id, size: 24, primary_key: true
    end
  end
end