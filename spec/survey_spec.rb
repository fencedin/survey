require 'spec_helper'

describe Survey do
  it { should validate_presence_of :name }
  it { should ensure_length_of(:name).is_at_least(3).is_at_most(50) }
  it { should validate_uniqueness_of :name }

  it { should have_many :questions }
end
