class UsersController < ApplicationController
  def show
    @active_borrowings = Current.user.borrowing_records.where(returned_at: nil).includes(:book)
    @borrowing_history = Current.user.borrowing_records.where.not(returned_at: nil).includes(:book)
  end
end

