require 'spec_helper'

describe Comment do
  it {should belong_to(:post)}
  it {should validate_presence_of(:body)}
  it {should validate_presence_of(:commenter)}
end