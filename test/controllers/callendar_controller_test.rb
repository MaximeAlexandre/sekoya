require 'test_helper'

class CallendarControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get callendar_show_url
    assert_response :success
  end

  test "should get form" do
    get callendar_form_url
    assert_response :success
  end

end
