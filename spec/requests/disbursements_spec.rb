require 'rails_helper'

describe 'Disbursements request', type: :request do
  describe 'search disbursements (GET /disbursements)' do
    before do
      rowe = create :rowe
      weissnat = create :weissnat

      (0..4).each do |i|
        create :disbursement, merchant: rowe, date: (Date.current - i.week).beginning_of_week
      end

      (0..9).each do |i|
        create :disbursement, merchant: weissnat, date: (Date.current - i.week).beginning_of_week
      end
    end

    context 'all disbursements' do
      before do
        get api_v1_disbursements_path
      end

      it 'URL work correctly' do
        expect(response).to have_http_status(200)
      end

      it 'returns all disbursements' do
        json = JSON.parse(response.body)
        expect(json.count).to eq(15)
      end
    end

    context 'given a merchant' do
      before do
        get api_v1_disbursements_path(merchant: Merchant.first.id)
      end

      it 'return merchant disbursements' do
        json = JSON.parse(response.body)
        expect(json.count).to eq(5)
      end
    end

    context 'given a merchant and week' do
      it 'number off week and year in ww.yyyy format' do
        get api_v1_disbursements_path(merchant: Merchant.first.id, week: "#{Date.current.cweek}.#{Date.current.year}")
        json = JSON.parse(response.body)

        expect(json.count).to eq(1)
      end

      it 'date in yyyy-mm-dd format' do
        get api_v1_disbursements_path(merchant: Merchant.first.id, week: "#{Date.current.year}-#{Date.current.month}-#{Date.current.day}")
        json = JSON.parse(response.body)

        expect(json.count).to eq(1)
      end

      it 'date in yyyy/mm/dd format' do
        get api_v1_disbursements_path(merchant: Merchant.first.id, week: "#{Date.current.year}/#{Date.current.month}/#{Date.current.day}")
        json = JSON.parse(response.body)

        expect(json.count).to eq(1)
      end

      it 'date in dd-mm-yyyy format' do
        get api_v1_disbursements_path(merchant: Merchant.first.id, week: "#{Date.current.day}-#{Date.current.month}-#{Date.current.year}")
        json = JSON.parse(response.body)

        expect(json.count).to eq(1)
      end

      it 'date in dd/mm/yyyy format' do
        get api_v1_disbursements_path(merchant: Merchant.first.id, week: "#{Date.current.day}/#{Date.current.month}/#{Date.current.year}")
        json = JSON.parse(response.body)

        expect(json.count).to eq(1)
      end
    end

    context 'time in the future' do
      future_date = Date.current + 1.week

      it 'number off week and year in the future' do
        get api_v1_disbursements_path(merchant: Merchant.first.id, week: "#{future_date.cweek}.#{future_date.year}")
        json = JSON.parse(response.body)
        expect(json.count).to eq(0)
      end

      it 'date in the future' do
        get api_v1_disbursements_path(merchant: Merchant.first.id, week: future_date)
        json = JSON.parse(response.body)
        expect(json.count).to eq(0)
      end
    end
  end
end
