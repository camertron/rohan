location      = Location.arel_table
order         = Order.arel_table
order_status  = OrderStatus.arel_table
order_data    = OrderDatum.arel_table
manager       = Manager.arel_table
staff         = MerchantStaff.arel_table
category      = Category.arel_table
item_return   = OrderItemReturn.arel_table
discount      = DiscountLocationType.arel_table
till          = Till.arel_table

arel_result = Order.select(
  location[:branch_name],
  order_data[:item_name].as("product_name"),
  order_data[:created_at].as("transaction_time"),
  category[:title].as("category"),
  discount[:name].as("discount_name"),
)

arel_result = arel_result
  .where(order[:current_status].eq(:completed).and(order[:payment_status].eq('t')).and(order[:location_id].eq('9')))
  .joins(order.join(location).on(order[:location_id].eq(location[:id])).join_sources)
  .joins(order.join(order_data).on(order[:id].eq(order_data[:order_id])).join_sources)
  .joins(order.join(order_status).on(order[:id].eq(order_status[:order_id])).join_sources)
  .joins(order_status.join(manager).on(manager[:id].eq(order_status[:attendee_id])).join_sources)
  .joins(order_status.join(staff).on(staff[:id].eq(order_status[:attendee_id])).join_sources)
  .joins(order_data.join(category).on(staff[:id].eq(order_status[:attendee_id])).join_sources)
  .joins(order_data.join(item_return).on(order_data[:id].eq(item_return[:order_datum_id])).join_sources)
  .joins(order_data.join(discount).on(staff[:id].eq(order_status[:attendee_id])).join_sources)
  .joins(order_status.join(till).on(order_status[:till_id].eq(till[:id])).join_sources)

puts arel_result.to_sql

puts ''

manual_res = Order.completed.payment_success.
        where(location_id: 9).
        joins("
            inner join locations on orders.location_id = locations.id
            left join order_statuses ord_stat on ord_stat.order_id = orders.id
            left join managers on managers.id = ord_stat.attendee_id
            left join merchant_staffs on merchant_staffs.id = ord_stat.attendee_id
            inner join order_data od on od.order_id = orders.id
            left join categories on od.category_id = categories.id
            left join order_item_returns on order_item_returns.order_datum_id = od.id
            left join discount_location_types dlt on od.discount_location_type_id = dlt.id
            left join tills tl on ord_stat.till_id = tl.id").
        select("
                locations.branch_name as location_name,
                orders.id as order_no,
                (CASE
                  WHEN ord_stat.attendee_type = 'Manager' THEN managers.username
                  WHEN ord_stat.attendee_type = 'MerchantStaff' THEN merchant_staffs.username
                  ELSE ''
                    end) as username,
                od.item_name as product_name,
                od.created_at as transaction_time,
                categories.title as category,
                dlt.name as discount_name").order("od.created_at desc")

puts manual_res.to_sql
