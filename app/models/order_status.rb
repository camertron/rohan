class OrderStatus < ActiveRecord::Base
  belongs_to :order
  belongs_to :till
  belongs_to :attendee, polymorphic: true
end
