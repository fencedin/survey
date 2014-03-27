require 'spec_helper'

describe Qresponse do
  it { should belong_to :response }
  it { should belong_to :question }
end
