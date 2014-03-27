class Question < ActiveRecord::Base

  validates :description, presence: true,
                          length: 3..100

  has_many :qsurveys
  has_many :qresponses
  has_many :surveys, through: :qsurveys
  has_many :responses, through: :qresponses
end
