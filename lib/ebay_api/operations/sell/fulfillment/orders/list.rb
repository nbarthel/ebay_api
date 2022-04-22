require_relative "../../../../paginated_collection"

class EbayAPI
  scope :sell do
    scope :fulfillment do
      scope :orders do
        operation :list do
          option :creation_date, optional: true
          option :last_modified_date, optional: true
          option :fulfillment_statuses, optional: true
          option :order_ids, optional: true
          option :limit, optional: true
          option :offset, optional: true

          validate { errors.add :limit_exceeded if order_ids && order_ids.size > 50 }
          validate do
            valid_statuses = %w(NOT_STARTED IN_PROGRESS FULFILLED)
            if fulfillment_statuses && (fulfillment_statuses - valid_statuses).length > 0
              errors.add :invalid_status
            end
          end

          http_method :get

          query do
            filter = {}

            format_time_range = ->(value) do
              if value.is_a?(Range)
                time_array = [value.first, value.last]
              else
                time_array = [value, nil]
              end
              return "[" + time_array.map { |t| t && t.utc.iso8601(3) }.join("..") + "]"
            end

            if creation_date
              filter[:creationdate] = format_time_range.call(creation_date)
            end

            if last_modified_date
              filter[:lastmodifieddate] = format_time_range.call(last_modified_date)
            end

            if fulfillment_statuses
              filter[:orderfulfillmentstatus] = "{" + fulfillment_statuses.join("|") + "}"
            end

            filter_string = filter.map { |k, v| "#{k}:#{v}" }.join(",")

            {
              filter: (filter_string if filter_string.length > 0),
              orderIds: (order_ids.map(&:to_s) if order_ids),
              limit: limit,
              offset: offset
            }.compact
          end

          middleware { PaginatedCollection::MiddlewareBuilder.call }

          response(200) do |*response|
            PaginatedCollection.new(self, response, "orders")
          end
        end
      end
    end
  end
end