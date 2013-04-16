require 'spec_helper'

describe Post do
  it {should have_many(:comments).dependent(:destroy)}
  it {should have_many(:tags)}
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:title)}
  it {should ensure_length_of(:title).is_at_least(5)}
end