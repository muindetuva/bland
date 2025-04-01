class BorrowingRecordsController < ApplicationController
  def create
    book_copy = BookCopy.find_by(id: params[:book_copy_id])


    if book_copy.nil? || book_copy.status == "borrowed"
      redirect_to books_path, alert: "Book is not available"
      return
    end

    borrowing = Current.user.borrowing_records.new(book_copy: book_copy, borrowed_at: Time.current)

    if borrowing.save
      book_copy.update(status: "borrowed")
      redirect_to book_path(book_copy.book), notice: "Book borrowed successfully!"
    else
      redirect_to book_path(book_copy.book), alert: "Something went wrong"
    end
  end

  def update
    borrowing = BorrowingRecord.find(params[:id])
    book = borrowing.book_copy.book


    if borrowing.user == Current.user
      if borrowing.update(returned_at: Time.current)
        borrowing.book_copy.update(status: "available")
        redirect_to request.referer || book_path(book), notice: "Book returned successfully!"
      else
        redirect_to request.referer || book_path(book), alert: "Something went wrong"
      end

    else
      redirect_to book_path(book), alert: "You cannot return a book you did not borrow"
    end
  end
end
