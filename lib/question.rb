class Question < ActiveRecord::Base

  validates :description, presence: true,
                          length: 3..100

  belongs_to :survey
  has_many :responses
end
