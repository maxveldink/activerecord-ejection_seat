# typed: false
# frozen_string_literal: true

require "active_record"

module ActiveRecord
  module EjectionSeat
    # Defines `#eject` `.buckle` methods for going between ActiveRecord models and Sorbet T::Structs.
    module Ejectable
      def ejects_to(klass)
        define_eject_method(klass)
        define_buckle_method(klass)
      end

      private

      def define_eject_method(klass)
        define_method(:eject) do
          attrs = attributes.deep_symbolize_keys
          attribute_props = klass.props.keys & attrs.keys

          klass.new(attrs.slice(*attribute_props))
        end

        alias_method :to_struct, :eject
      end

      def define_buckle_method(klass)
        define_singleton_method(:buckle) do |struct|
          raise ArgumentError if struct.class != klass

          attrs = struct.serialize
          props = attrs.keys & column_names

          new(attrs.slice(*props))
        end

        singleton_class.send :alias_method, :from_struct, :buckle
      end
    end
  end

  class Base
    extend EjectionSeat::Ejectable
  end
end
