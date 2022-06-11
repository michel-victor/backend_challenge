require 'rails_helper'

describe Shopper do
  describe 'save shopper' do
    context 'with all attributes' do
      before { create :vickey }

      it { expect have_many(:orders).dependent(:destroy) }
      it { expect have_many(:merchants).through(:orders) }
      it { expect validate_presence_of(:name) }
      it { expect validate_presence_of(:email) }
      it { expect validate_presence_of(:nif) }

      it 'returns shopper' do
        expect(Shopper.first.name).to eq('Vickey')
        expect(Shopper.first.email).to eq('vickey@not_gmail.com')
        expect(Shopper.first.nif).to eq('411111111Z')
      end
    end
  end
end