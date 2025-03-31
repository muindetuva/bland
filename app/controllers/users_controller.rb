class UsersController < ApplicationController
  def show
    @active_borrowings = Current.user.borrowing_records.where(returned_at: nil).includes(book_copy: :book)
    @borrowing_history = Current.user.borrowing_records.where.not(returned_at: nil).includes(book_copy: :book)
  end
end

