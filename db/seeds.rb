50.times do |x|
  cost = x + 0.51
  Order.create(merchant_id: x, shopper_id: x+1, total_cost: cost)
end
