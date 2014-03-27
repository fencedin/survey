class Response < ActiveRecord::Base

  validates :answer, presence: true,
                     length: 1..140

  has_many :qresponses
  has_many :questions, through: :qresponses
end

