class CreateBorrowingRecords < ActiveRecord::Migration[8.0]
  def change
    create_table :borrowing_records do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.datetime :borrowed_at, null: false
      t.datetime :due_date, null: false
      t.datetime :returned_at

      t.timestamps
    end
  end
end
