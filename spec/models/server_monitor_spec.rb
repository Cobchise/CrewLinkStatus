require 'rails_helper'

RSpec.describe ServerMonitor, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:server_monitor)).to be_valid
  end
end
