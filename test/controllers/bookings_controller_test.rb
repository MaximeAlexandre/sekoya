require 'test_helper'

class BookingsControllerTest < ActionDispatch::IntegrationTest
  test "should get new:," do
    get bookings_new:,_url
    assert_response :success
  end

  test "should get create:," do
    get bookings_create:,_url
    assert_response :success
  end

  test "should get show:," do
    get bookings_show:,_url
    assert_response :success
  end

  test "should get update:" do
    get bookings_update:_url
    assert_response :success
  end

end
