require 'rails_helper'

describe Merchant do
  describe 'save merchant' do
    context 'with all attributes' do
      before { create :rowe }

      it { expect have_many(:orders).dependent(:destroy) }
      it { expect have_many(:merchants).through(:orders) }
      it { expect have_many(:disbursements).dependent(:destroy) }
      it { expect validate_presence_of(:name) }
      it { expect validate_presence_of(:email) }
      it { expect validate_presence_of(:cif) }
      it { expect validate_uniqueness_of(:nif).case_insensitive }

      it 'returns merchant' do
        expect(Merchant.first.name).to eq('Rowe')
        expect(Merchant.first.email).to eq('info@rowe.com')
        expect(Merchant.first.cif).to eq('B611111111')
      end
    end
  end

  describe 'merchant disburse' do
    before do
      merchant = create :merchant
      shopper = create :shopper
      create :order, :completed, :under_50, merchant: merchant, shopper: shopper
      create :order, :completed, :between_50_300, merchant: merchant, shopper: shopper
      create :order, :completed, :over_300, merchant: merchant, shopper: shopper
    end

    context 'given a week in' do
      it 'number off week and year' do
        Merchant.first.disburse Date.current.cweek, Date.current.year
        expect(Disbursement.first.amount.to_d).to eq(565.62)
      end

      it 'object date' do
        Merchant.first.disburse Date.current
        expect(Disbursement.first.amount.to_d).to eq(565.62)
      end

      it 'string date in yyyy-mm-dd format' do
        Merchant.first.disburse "#{Date.current.year}-#{Date.current.month}-#{Date.current.day}"
        expect(Disbursement.first.amount.to_d).to eq(565.62)
      end

      it 'string date in yyyy/mm/dd format' do
        Merchant.first.disburse "#{Date.current.year}/#{Date.current.month}/#{Date.current.day}"
        expect(Disbursement.first.amount.to_d).to eq(565.62)
      end

      it 'string date in dd-mm-yyyy format' do
        Merchant.first.disburse "#{Date.current.day}-#{Date.current.month}-#{Date.current.year}"
        expect(Disbursement.first.amount.to_d).to eq(565.62)
      end

      it 'string date in dd/mm/yyyy format' do
        Merchant.first.disburse "#{Date.current.day}/#{Date.current.month}/#{Date.current.year}"
        expect(Disbursement.first.amount.to_d).to eq(565.62)
      end
    end
  end

end