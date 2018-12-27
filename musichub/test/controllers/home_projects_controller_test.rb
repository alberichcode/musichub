require 'test_helper'

class HomeProjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get home_projects_index_url
    assert_response :success
  end

end
