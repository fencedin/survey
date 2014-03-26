class Response < ActiveRecord::Base

  validates :answer, presence: true,
                     length: 1..140

  belongs_to :question
end

