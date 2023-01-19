# typed: false
# frozen_string_literal: true

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
          klass.new(
            PropsBuilder.new(
              model: self,
              target_struct: klass
            ).build
          )
        end

        alias_method :to_struct, :eject
      end

      def define_buckle_method(klass)
        define_singleton_method(:buckle) do |struct|
          raise ArgumentError if struct.class != klass

          new(AttributesBuilder.new(struct: struct, target_model: self).build)
        end

        singleton_class.send :alias_method, :from_struct, :buckle
      end
    end
  end

  class Base
    extend EjectionSeat::Ejectable
  end
end
