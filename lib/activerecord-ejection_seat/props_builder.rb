# typed: strict
# frozen_string_literal: true

require "sorbet-runtime"

# Creates initialization payload for targeted T::Struct
class PropsBuilder
  extend T::Sig

  Attributes = T.type_alias { T::Hash[Symbol, T.untyped] }

  sig do
    params(
      attributes_from_model: Attributes,
      target_props: Attributes
    ).void
  end
  def initialize(attributes_from_model, target_props)
    @attributes_from_model = attributes_from_model
    @target_props = target_props
  end

  sig { returns(Attributes) }
  def build
    built_props = {}

    attributes_from_model.each do |k, v|
      prop_type = target_props.dig(k, :type)

      built_props[k] = if prop_type < T::Enum
                         prop_type.deserialize(v)
                       else
                         v
                       end
    end

    built_props
  end

  private

  sig { returns(Attributes) }
  attr_reader :attributes_from_model, :target_props
end
