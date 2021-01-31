require 'cgi'

module PaypalShipping
  class OrderGetShipping
    attr_accessor :path, :body, :headers, :verb

    def initialize(order_id)
      @headers = {}
      @body = nil
      @verb = "GET"
      @path = "/v2/checkout/orders/{order_id}?"

      @path = @path.gsub("{order_id}", CGI::escape(order_id.to_s))
      @headers["Content-Type"] = "application/json"
    end

  end

  class OrderUpdateShipping
    attr_accessor :path, :body, :headers, :verb

    def initialize
      @headers = {}
      @body = nil
      @verb = "POST"
      @path = "/v1/shipping/trackers-batch"
      # @path = @path.gsub("{id}", CGI::escape("#{transaction_id}-#{tracking_number}".to_s))
      @headers["Content-Type"] = "application/json"
    end

    def request_body(body)
      @body = body
    end

  end
end