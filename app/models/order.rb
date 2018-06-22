class Order < ActiveRecord::Base
  belongs_to :location
  has_many :order_statuses
  has_many :order_data

  scope :completed, -> { }
  scope :payment_success, -> { }
end
