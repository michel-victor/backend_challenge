require "test_helper"

class DisbursementsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get disbursements_index_url
    assert_response :success
  end
end
