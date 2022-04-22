#
# Sell Inventory API
#
class EbayAPI
  scope :sell do
    scope :fulfillment do
      path { "fulfillment/v#{EbayAPI::SELL_FULFILLMENT_VERSION[/^\d+/]}" }

      require_relative "fulfillment/orders"
    end
  end
end
