# typed: true
# frozen_string_literal: true

require "test_helper"

class EjectableTest < Minitest::Test
  def setup
    @location_model = Location.new(name: "Florida")
    @location_struct = Types::Location.new(name: "Florida")
    @post_struct = Types::Post.new(title: "Testing 123", status: Types::PostStatus::Draft)
    @user_struct = Types::User.new(name: "Max", age: 28, location: @location_struct, is_active: true)
  end

  def test_eject_handles_simple_fields
    assert_equal @location_model.eject, @location_struct
  end

  def test_to_struct_is_an_alias_for_eject
    location_model = Location.new(name: "Florida")

    assert_equal location_model.to_struct, location_model.eject
  end

  def test_eject_can_handle_t_enum
    post_model = Post.new(title: "Testing 123", status: "draft")

    assert_equal post_model.eject, @post_struct
  end

  def test_eject_can_handle_t_struct
    user_model = User.new(name: "Max", age: 28, location: @location_model, is_active: true)

    assert_equal user_model.eject, @user_struct
  end

  def test_eject_handles_incorrect_props_being_built
    pet_model = SimplePet.new(breed: "Brittany")

    assert_raises(TypeError) { pet_model.eject }
  end

  def test_eject_handles_incorrect_deserialization_of_enum
    post_model = Post.new(title: "Testing 123", status: "published")

    assert_raises(TypeError) { post_model.eject }
  end

  def test_buckle_handles_invalid_class_passed_in
    assert_raises ArgumentError do
      Location.buckle(Types::Pet.new(name: "Java", breed: "Long-haired Cat"))
    end
  end

  def test_buckle_handles_simple_fields
    new_location = Location.buckle(@location_struct)

    assert_kind_of Location, new_location
    assert_equal "Florida", new_location.name
  end

  def test_buckle_handles_t_enum_fields
    post_model = Post.buckle(@post_struct)

    assert_kind_of Post, post_model
    assert_equal "Testing 123", post_model.title
    assert_equal "draft", post_model.status
  end

  # rubocop:disable Minitest/MultipleAssertions
  def test_buckle_handles_t_struct_fields
    user_model = User.buckle(@user_struct)

    assert_kind_of User, user_model
    assert_equal "Max", user_model.name
    assert_equal 28, user_model.age
    assert_kind_of Location, user_model.location
    assert_equal "Florida", user_model.location&.name
  end
  # rubocop:enable Minitest/MultipleAssertions

  def test_from_struct_is_an_alias_for_buckle
    location_model = Location.from_struct(@location_struct)

    assert_kind_of Location, location_model
    assert_equal "Florida", location_model.name
  end
end
