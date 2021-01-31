require 'cgi'

module PaypalShipping
  class OrderGetShipping
    attr_accessor :path, :body, :headers, :verb

    def initialize(transaction_id, tracking_number)
      @headers = {}
      @body = nil
      @verb = "GET"
      @path = "/v1/shipping/trackers/{id}"
      # The ID of the tracker in the transaction_id-tracking_number format.
      @path = @path.gsub("{id}", CGI::escape("#{transaction_id}-#{tracking_number}"))
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
      @headers["Content-Type"] = "application/json"
    end

    def request_body(body)
      @body = body
    end

  end
end