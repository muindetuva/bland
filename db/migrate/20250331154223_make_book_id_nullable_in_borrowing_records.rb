class MakeBookIdNullableInBorrowingRecords < ActiveRecord::Migration[8.0]
  def change
    change_column_null :borrowing_records, :book_id, true
  end
end
