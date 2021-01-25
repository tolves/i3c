require 'paypal-checkout-sdk'

module PaypalClient
  class << self

    def environment
      client_id = 'ASXaqbwl5OUI96LhkLtD1Z5nTBNbryp4x0LX7kLnkkBH8EROvNXHAeQ9MzfWuxO5GiUtyksfi_D6S0z-' #Rails.application.credentials.dev[:paypal] #ENV.fetch("PAYPAL_CLIENT_ID")
      client_secret = 'EIm5IFFReNqiUk5EGelFZte3nUe0sn60ozdwg_Vx9BEBKBJC6PS6jtuYiN4Y8sEjYcxu4kPDlT5QPRLE' #Rails.application.credentials.dev[:paypal_secret] #ENV.fetch("PAYPAL_CLIENT_SECRET")

      PayPal::SandboxEnvironment.new(client_id, client_secret)
    end

    # Returns PayPal HTTP client instance with environment that has access
    # credentials context. Use this instance to invoke PayPal APIs, provided the
    # credentials have access.
    def client
      PayPal::PayPalHttpClient.new(self.environment)
    end

    # Utility to convert Openstruct Object to JSON hash.
    def openstruct_to_hash(object, hash = {})
      object.each_pair do |key, value|
        hash[key] = value.is_a?(OpenStruct) ? openstruct_to_hash(value) : value.is_a?(Array) ? array_to_hash(value) : value
      end
      hash
    end

    # Utility to convert array of OpenStruct to hash.
    def array_to_hash(array, hash = [])
      array.each do |item|
        x = item.is_a?(OpenStruct) ? openstruct_to_hash(item) : item.is_a?(Array) ? array_to_hash(item) : item
        hash << x
      end
      hash
    end
  end
end