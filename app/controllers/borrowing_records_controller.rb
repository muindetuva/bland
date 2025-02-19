class BorrowingRecordsController < ApplicationController
  def create
    book = Book.find(params[:book_id])

    if BorrowingRecord.exists?(book: book, returned_at: nil)
      redirect_to book_path(book), alert: "Book is already borrowed"
      registration_path
    end

    borrowing = Current.user.borrowing_records.new(book: book, borrowed_at: Time.current)

    if borrowing.save
      redirect_to book_path(book), notice: "Book borrowed successfully!"
    else
      redirect_to book_path(book), alert: "Something went wrong"
    end
  end

  def update
    borrowing = BorrowingRecord.find(params[:id])

    if borrowing.user == Current.user
      if borrowing.update(returned_at: Time.current)
        redirect_to request.referer || book_path(borrowing.book), notice: "Book returned successfully!"
      else
        redirect_to request.referer || book_path(borrowing.book), alert: "Something went wrong"
      end

    else
      redirect_to book_path(borrowing.book), alert: "You cannot return a book you did not borrow"
    end
  end
end
