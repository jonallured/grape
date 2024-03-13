# frozen_string_literal: true

module Grape
  module Extensions
    module ActionController
      class Parameters
        module ParamBuilder
          extend ::ActiveSupport::Concern

          included do
            namespace_inheritable(:build_params_with, Grape::Extensions::ActionController::Parameters::ParamBuilder)
          end

          def params_builder
            Grape::Extensions::ActionController::Parameters::ParamBuilder
          end

          def build_params
            ::ActionController::Parameters.new(rack_params).tap do |params|
              params.deep_merge!(grape_routing_args) if env.key?(Grape::Env::GRAPE_ROUTING_ARGS)
            end
          end
        end
      end
    end
  end
end
