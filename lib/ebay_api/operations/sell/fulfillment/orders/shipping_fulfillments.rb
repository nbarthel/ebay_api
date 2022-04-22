require_relative "shipping_fulfillments/create"
require_relative "shipping_fulfillments/get"
require_relative "shipping_fulfillments/list"

class EbayAPI
  scope :sell do
    scope :fulfillment do
      scope :orders do
        scope :shipping_fulfillments do
          path { "#{order_id}/shipping_fulfillment" }
        end
      end
    end
  end
end