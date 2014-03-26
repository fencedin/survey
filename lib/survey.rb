class Survey < ActiveRecord::Base

  validates :name, presence: true,
                   length: 3..50,
                   uniqueness: true

  has_many :questions

end
