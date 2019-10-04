require 'test_helper'

class LabelingsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get labelings_create_url
    assert_response :success
  end

  test "should get destroy" do
    get labelings_destroy_url
    assert_response :success
  end

end
