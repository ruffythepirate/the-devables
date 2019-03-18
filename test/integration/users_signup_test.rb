require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "",
      email: "user@invlid",
      password: "foo",
      password_confirmation: "bar"}}
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
  end

  test "valid signup" do
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: "my username",
                                       email: "user@valid.com",
      password: "foofoo",
      password_confirmation: "foofoo"}}
    end
    follow_redirect!
    assert_template 'users/show'
  end
end
