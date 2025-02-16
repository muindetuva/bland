class BorrowingRecord < ApplicationRecord
  before_validation :set_default_due_date

  belongs_to :user
  belongs_to :book


  validates :borrowed_at , presence: true

  # Ensure a book cannot be borrowed twice at the same time
  validates :book_id, uniqueness: { scope: :returned_at, message: "is already borrowed and must be returned first" }, unless: -> { returned_at.present? }



  private
  def set_default_due_date
    # Prevents tests from crashing and also lets the model validations deal with this.
    # If we ever have a feature of updating due_date manually, this should be rethought since it'll overwrite
    self.due_date = borrowed_at + 2.weeks  unless borrowed_at.nil?
  end

end
