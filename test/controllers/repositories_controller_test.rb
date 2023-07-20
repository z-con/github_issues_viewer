require "test_helper"

class RepositoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get issues" do
    get repositories_issues_url
    assert_response :success
  end
end
