Given(/^that "(.*?)" is a country$/) do |name|
  FactoryGirl.create :country, name: name
end

Given(/^that the following supplies exist:$/) do |supplies|
  supplies.hashes.each do |supply|
    FactoryGirl.create :supply, shortcode: supply['shortcode'], name: supply['name']
  end
end

Given(/^that the following orders have been made$/) do |orders|
  i = 0
  orders.hashes.each do |order|
    FactoryGirl.create :order, user: User.find(order['pcv']),
      supply: Supply.lookup(order['supply']),
      location: User.find(order['pcv']).location,
      created_at: i.business_days.before(Time.now)
    i = i + 1
  end

  # TODO: Add one to "Response Tracker" table. Set "responded_at: Time.now"
end

Given(/^that the following pcmos exist:$/) do |pcmos|
  pcmos.hashes.each do |pcmo|
    FactoryGirl.create :pcmo, country: Country.where(name: pcmo[:country]).first!
  end
end
