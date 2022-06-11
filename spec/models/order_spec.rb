require 'rails_helper'

describe Order do
  describe 'save order' do
    context 'completed' do
      before { create :order, :completed }

      it { expect belong_to(:merchant) }
      it { expect belong_to(:shopper) }
      it { expect validate_presence_of(:amount) }
      it { expect validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }

      it 'returns order' do
        expect(Order.first.merchant.name).to eq('Rowe')
        expect(Order.first.shopper.name).to eq('Vickey')
        expect(Order.first.amount).to eq(150)
        expect(Order.first.completed_at).not_to eq(nil)
      end
    end
  end
end