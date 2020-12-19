FactoryBot.define do
  factory :server_monitor do
    name { 'factoryMonitor' }
    url { 'https://crewlink.among-us.tech' } 
    current_users { 100 }
    available { true }
    region { 'North America' }
    enabled { true }
  end
end
