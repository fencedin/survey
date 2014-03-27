require 'spec_helper'

describe Qsurvey do
  it { should belong_to :survey }
  it { should belong_to :question }
end
