require 'rails_helper'
require 'spec_helper'

describe Restaurant, type: :model do
  it {is_expected.to have_many :reviews }
end

describe Review do
  it { should belong_to(:restaurant) }
end


describe Restaurant, :type => :model do
  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: 'kf')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it 'does not accept restaurant unless unique' do
    Restaurant.create(name: 'whatever')
    restaurant = Restaurant.new(name: 'whatever')
    expect(restaurant).to have(1).error_on(:name)
  end
end
