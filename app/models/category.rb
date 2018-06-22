class Category < ActiveRecord::Base
  has_many :order_data
end
