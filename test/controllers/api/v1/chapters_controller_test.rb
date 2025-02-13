require "test_helper"

class Api::V1::ChaptersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "should return all chapters in index" do
    get api_v1_chapters_url
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal Chapter.count, json_response["data"].length
  end

  test "should show chapter ordered by smaller number" do
    get api_v1_chapters_url
    assert_response :success

    json_response = JSON.parse(response.body)
    assert json_response.key?("data")

    # puts json_response["data"].pluck("number")
    smallest = json_response["data"].pluck("number").min
    assert_equal json_response["data"][0]["number"], smallest
  end

  test "should show chapter with verses" do
    chapter = chapters(:one)
    get api_v1_chapter_url(chapter)
    assert_response :success

    json_response = JSON.parse(response.body)
    assert json_response.key?("data")

    assert json_response["data"].key?("chapter")
    assert json_response["data"].key?("verses")
  end

  test "should return correct chapter data structure" do
    chapter = chapters(:one)
    get api_v1_chapter_url(chapter)
    assert_response :success

    json_response = JSON.parse(response.body)
    chapter_data = json_response["data"]["chapter"]

    assert_not_nil chapter_data["id"]
    assert_not_nil chapter_data["number"]
    assert_not_nil chapter_data["title"]
  end

  test "should return error for invalid chapter" do
    get api_v1_chapter_url(999)
    assert_response :not_found

    json_response = JSON.parse(response.body)
    assert json_response.key?("error")
  end
end
