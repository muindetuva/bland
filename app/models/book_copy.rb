class BookCopy < ApplicationRecord
  belongs_to :book
  has_many :borrowing_records, dependent: :destroy
  has_many :users, through: :borrowing_records

  validates :status, inclusion: { in: %w[available borrowed] }

  before_create :set_default_status

  private

  def set_default_status
    self.status ||= "available"
  end

end
