class PagesController < ApplicationController
  allow_unauthenticated_access only: [ :home ]
  before_action :require_authentication, only: [ :dashboard ]

  def home
    render layout: false
    redirect_to dashboard_path if authenticated?
  end
  def dashboard
    @borrowed_books = Current.user.borrowed_books.joins(:borrowing_records)
                             .where(borrowing_records: { returned_at: nil })
                             .includes(:borrowing_records)

    @available_books = Book.where.not(id: BorrowingRecord.where(returned_at: nil).pluck(:book_id))

  end
end
