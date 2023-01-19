# typed: strict
# frozen_string_literal: true

# Creates initialization payload for targeted ActiveRecord model
class AttributesBuilder
  extend T::Sig

  sig { params(struct: T::Struct, target_model: T.class_of(ActiveRecord::Base)).void }
  def initialize(struct:, target_model:)
    @struct = struct
    @target_model = target_model
  end

  sig { returns(T::Hash[String, T.untyped]) }
  def build
    attrs = struct.serialize
    props = attrs.keys & target_model.column_names.map { |name| name.delete_suffix("_id") }

    attrs.slice(*props).to_h { |key, value| build_attribute(name: key, value: value) }
  end

  private

  sig { params(name: String, value: T.untyped).returns(T::Array[T.untyped]) }
  def build_attribute(name:, value:)
    if value.is_a?(Hash)
      association_class = target_model.reflect_on_all_associations.find do |association|
        association.name.to_s == name
      end&.klass

      value = association_class&.new(value)
    end

    [name, value]
  end

  sig { returns(T::Struct) }
  attr_reader :struct

  sig { returns(T.class_of(ActiveRecord::Base)) }
  attr_reader :target_model
end
