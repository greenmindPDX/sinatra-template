require 'spec_helper'

describe Order do

  it 'will get created' do
    Order.create!( merchant_id: 1,  shopper_id: 1, total_cost: 5 )
    expect( Order.count ).to eq(1)
  end

end
