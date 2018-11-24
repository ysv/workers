class Lot < ActiveRecord::Base
  has_many :bids
end
