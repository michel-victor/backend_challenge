require 'rails_helper'

describe Disbursement do
  describe 'save disbursement' do
    context 'with all attributes' do
      before { create :disbursement }

      it { expect belong_to(:merchant) }
      it { expect validate_presence_of(:amount) }
      it { expect validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
      it { expect validate_uniqueness_of(:merchant).scoped_to(:date) }

      it 'returns disbursement' do
        expect(Disbursement.first.merchant.name).to eq('Rowe')
        expect(Disbursement.first.amount).to eq(100)
        expect(Disbursement.first.date).not_to eq(nil)
      end
    end
  end
end