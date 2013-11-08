require 'spec_helper'

describe Sale do
  it { should have_many(:purchases) }
  it { should have_many(:products).through(:purchases) }
end
