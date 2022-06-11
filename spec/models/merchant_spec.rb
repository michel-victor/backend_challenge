require 'rails_helper'

describe Merchant do
  describe 'save merchant' do
    context 'with all attributes' do
      before { create :rowe }

      it { expect have_many(:orders) }
      it { expect have_many(:merchants).through(:orders) }
      it { expect have_many(:disbursements) }
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
end