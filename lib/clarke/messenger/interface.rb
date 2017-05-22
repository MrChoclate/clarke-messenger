module Clarke
  module Messenger
    class << self
      def parse (request)
        # Parse the incomming request and return a generic message
        Parser.parse_request(request)
      end

      def deliver (responses)
        # Convert the generic responses into messenger responses and then send it
        responses.each_with_index do |response, i|
          ResponseSender.send_response(response)

          if Config.delay_between_requests > 0
            if i != responses.length - 1
              ResponseSender.send_response(Clarke::Response.new(response.recipient, typings: true))
              sleep Config.delay_between_requests
            else
              ResponseSender.send_response(Clarke::Response.new(response.recipient, typings: false))
            end
          end
        end
      end
    end
  end
end
