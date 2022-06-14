require 'rails_helper'

describe 'Disbursements controller', type: :request do
  describe 'index (GET /disbursements)' do
    it "should get index" do
      get api_v1_disbursements_url
      assert_response :success
    end
  end
end