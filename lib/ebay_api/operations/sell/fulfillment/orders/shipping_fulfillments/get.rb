class EbayAPI
  scope :sell do
    scope :fulfillment do
      scope :orders do
        scope :shipping_fulfillments do
          operation :get do
            option :order_id
            option :fulfillment_id
            http_method :get
            path { fulfillment_id.to_s }
            response(200) { |_, _, (data, *)| data }
          end
        end
      end
    end
  end
end