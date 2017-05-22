module Clarke
  module Messenger
    module Responses
      class ActionTypings < Messenger::Responses::Base
        def initialize (recipient, typings_bool, options = {})
          super(recipient)
          @typings_bool = typings_bool
        end

        def get_request_body
          request_body = request_body_initializer()
          request_body[:sender_action] = @typings_bool ? 'typing_on' : 'typing_off'
          request_body.to_json
        end
      end
    end
  end
end
