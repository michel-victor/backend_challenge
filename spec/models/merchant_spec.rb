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

      it 'returns merchant' do
        expect(Merchant.first.name).to eq('Rowe')
        expect(Merchant.first.email).to eq('info@rowe.com')
        expect(Merchant.first.cif).to eq('B611111111')
      end
    end
  end

  describe 'merchant disburse' do
    before do
      create :order, :completed, :under_50
      create :order, :completed, :between_50_300
      create :order, :completed, :over_300

      # create_list :order, 3, :completed
    end

    context 'given a week in' do
      it 'number off week and year' do
        Merchant.first.disburse Date.current.cweek, Date.current.year
        # expect(Order.completed.count).to eq(3)
        # expect(Order.last.amount_with_fee).to eq(412.66)
        # expect(Order.last.completed_at.to_date).to eq(Date.today)
        expect(Disbursement.first.amount.to_f).to eq(565.61)
      end
    end
  end

end