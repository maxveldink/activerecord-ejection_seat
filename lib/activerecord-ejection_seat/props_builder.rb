# typed: strict
# frozen_string_literal: true

require "sorbet-runtime"

# Creates initialization payload for targeted T::Struct
class PropsBuilder
  extend T::Sig

  sig do
    params(
      model: ActiveRecord::Base,
      target_struct: T.class_of(T::Struct)
    ).void
  end
  def initialize(model:, target_struct:)
    @model = model
    @target_struct = target_struct
  end

  sig { returns(T::Hash[Symbol, T.untyped]) }
  def build
    target_struct.props.keys.each_with_object({}) do |prop_name, returned_props|
      attribute = model.send(prop_name)
      prop_type = target_struct.props.dig(prop_name, :type)

      attribute = prop_type.deserialize(attribute) if prop_type < T::Enum
      if prop_type < T::Struct
        attribute = prop_type.new(PropsBuilder.new(model: attribute, target_struct: prop_type).build)
      end

      returned_props[prop_name] = attribute
    end
  end

  private

  sig { returns(ActiveRecord::Base) }
  attr_reader :model

  sig { returns(T.class_of(T::Struct)) }
  attr_reader :target_struct
end
