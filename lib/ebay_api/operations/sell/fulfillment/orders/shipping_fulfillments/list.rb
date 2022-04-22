class EbayAPI
  scope :sell do
    scope :fulfillment do
      scope :orders do
        scope :shipping_fulfillments do
          operation :list do
            option :order_id
            http_method :get
          end
        end
      end
    end
  end
end