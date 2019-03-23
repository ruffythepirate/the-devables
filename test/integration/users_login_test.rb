require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "failed login" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {session: { email: "hello@mail.com", password: "wrong"}}
    assert_template 'sessions/new'
    assert_not flash.empty?

    get root_path
    assert flash.empty?, "Expected there to be no flash"
  end
end
