require 'spec_helper'

describe Response do
  it { should validate_presence_of :answer }
  it { should ensure_length_of(:answer).is_at_least(1).is_at_most(140) }

  it { should belong_to :question}
end
