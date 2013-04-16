require 'spec_helper'

describe Tag do
  it {should belong_to(:post)}
  it {should validate_presence_of(:name)}
end