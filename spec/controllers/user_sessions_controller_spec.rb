require 'spec_helper'

describe UserSessionsController do
  fixtures :users

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "returns http success" do
      @user = users(:test)
      login_user
      get 'destroy'
      response.should redirect_to posts_url
    end
  end

end
