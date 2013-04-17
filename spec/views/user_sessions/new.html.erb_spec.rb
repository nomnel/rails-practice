require 'spec_helper'

describe "user_sessions/new.html.erb" do
  before(:each) do
    assign(:user, stub_model(User,
      :username => "MyString",
      :email => "MyString",
      :password => "MyString",
      :password_confirmation => "MyString"
    ).as_new_record)
  end

  it "renders new user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", user_sessions_path, "post" do
      assert_select "input#username[name=?]", "username"
      assert_select "input#password[name=?]", "password"
    end
  end
end