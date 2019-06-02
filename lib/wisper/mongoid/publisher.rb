require 'active_support/concern'
require 'wisper/publisher'

module Wisper
  module Mongoid
    # Broadcasts Wisper events when Mongoid records are saved.
    module Publisher
      extend ActiveSupport::Concern
      included do
        include Wisper::Publisher

        after_validation :after_validation_broadcast
        after_create :after_create_broadcast,  on: :create
        after_update :after_update_broadcast,  on: :update
        after_destroy :after_destroy_broadcast, on: :destroy
      end

      private

      def after_validation_broadcast
        action = new_record? ? 'create' : 'update'
        broadcast("#{action}_#{broadcast_model_name_key}_failed", self) unless errors.empty?
      end

      def after_create_broadcast
        broadcast(:after_create, self)
        broadcast("create_#{broadcast_model_name_key}_successful", self)
      end

      def after_update_broadcast
        broadcast(:after_update, self)
        broadcast("update_#{broadcast_model_name_key}_successful", self)
      end

      def after_destroy_broadcast
        broadcast(:after_destroy, self)
        broadcast("destroy_#{broadcast_model_name_key}_successful", self)
      end

      def broadcast_model_name_key
        self.class.model_name.param_key
      end
    end
  end
end
