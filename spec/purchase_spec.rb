require 'spec_helper'

describe Purchase do
  it { should belong_to(:product) }
  it { should belong_to(:sale) }

  
end