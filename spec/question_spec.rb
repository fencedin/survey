require 'spec_helper'

describe Question do
  it { should validate_presence_of :description }
  it { should ensure_length_of(:description).is_at_least(3).is_at_most(100) }

  it { should have_many :qsurveys }
  it { should have_many :qresponses }
  it { should have_many(:surveys).through :qsurveys }
  it { should have_many(:responses).through :qresponses }
end
