require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "should get new" do
    get users_new_url
    assert_response :success
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end

  test "should no be allowed to update admin property" do
    log_in_as @other_user
    patch user_path(@other_user), params: {
      user: {
        email: @other_user.email,
        password: 'password',
        password_confirmation: 'password',
        admin: true
      }}

    assert_not @other_user.reload.admin?
  end

  test "should redirect destroy when no logged in" do
    assert_no_difference "User.count" do
      delete user_path(@other_user)
    end

    assert_redirected_to login_path
  end

  test "should redirect destroy when not admin" do
    log_in_as @other_user
    assert_no_difference "User.count" do
      delete user_path(@other_user)
    end
    assert_redirected_to root_url
  end
end
