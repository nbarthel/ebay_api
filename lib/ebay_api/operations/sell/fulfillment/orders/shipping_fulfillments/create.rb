class EbayAPI
  scope :sell do
    scope :fulfillment do
      scope :orders do
        scope :shipping_fulfillments do
          operation :create do
            option :order_id
            option :data
            http_method :post
            body do
              data
            end
            response(201) { |_, _, (data, *)| data }
          end
        end
      end
    end
  end
end