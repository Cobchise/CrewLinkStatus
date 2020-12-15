class ServerVersion < ApplicationRecord
    has_and_belongs_to_many :server_monitors
    validates :name, presence: true 
    validates_format_of :name, with: /\A202[0-1].[0-1][0-9].([0-3][0-9]|[0-9])\z/ 
end
