require "test_helper"

class Api::V1::VersesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "should show verse ordered by smaller number" do
    get api_v1_verses_url
    assert_response :success

    json_response = JSON.parse(response.body)
    assert json_response.key?("data")

    smallest = json_response["data"].pluck("verse_number").min
    assert_equal json_response["data"][0]["verse_number"], smallest
  end

  test "random endpoint should return a valid verse" do
    get api_v1_verses_random_url
    assert_response :success

    json_response = JSON.parse(response.body)
    assert json_response.key?("data")
  end

  test "should return error for invalid verse" do
    get api_v1_verse_url(999)
    assert_response :not_found

    json_response = JSON.parse(response.body)
    assert json_response.key?("error")
  end
end
