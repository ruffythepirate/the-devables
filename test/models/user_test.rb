require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                    password: "any", password_confirmation: "any")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 31
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 31
    assert_not @user.valid?
  end

  test "email validation should work for valid addresses" do
    valid_addresses = %w[user@email.com U_a-s_r534@gmail.com alice@GMAIL.com]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should fail for invalid addresses" do
    invalid_addresses = %w[user@email,com U_a-s_r534_gmail.com alice@GMAIL+etc.com]
    invalid_addresses.each do |valid_address|
      @user.email = valid_address
      assert_not @user.valid?, "#{valid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email should be lowercase on save" do
    @user.email = @user.email.upcase
    @user.save
    @user.reload
    assert_equal @user.email, @user.email.downcase
  end
end

