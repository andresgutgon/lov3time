# frozen_string_literal: true

module Api
  module AuthOverrides
    # This is here only to avoid having `update` and `delete` actions
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      def update
        # Do nothing
        render_update_success
      end

      def destroy
        # Do nothing
        render_update_success
      end
    end
  end
end
