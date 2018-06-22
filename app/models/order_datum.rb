class OrderDatum < ActiveRecord::Base
  belongs_to :order
  belongs_to :category
  belongs_to :discount_location_type
  has_many :order_item_returns
end
