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

  test "successful login" do
    get root_path
    assert_select 'a[href=?]', login_path

    get login_path
    post login_path, params: {session: { email: "michael@example.com", password: "password"}}

    assert is_logged_in?
    assert_select 'a[href=?]', login_path, false
  end

  test "logging out" do
    get login_path
    post login_path, params: {session: { email: "michael@example.com", password: "password"}}

    assert is_logged_in?

    delete logout_path
    assert_not is_logged_in?
    get login_path
    assert_select 'a[href=?]', login_path
  end
end
