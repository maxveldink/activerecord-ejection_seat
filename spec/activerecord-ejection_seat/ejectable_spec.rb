# typed: false
# frozen_string_literal: true

require "spec_helper"

RSpec.describe ActiveRecord::EjectionSeat::Ejectable do
  let(:user_model) { User.new(name: "Max", age: 28, location: location_model) }
  let(:user_struct) { Types::User.new(name: "Max", age: 28, location: location_struct) }
  let(:post_model) { Post.new(title: "Testing 123", status: "draft") }
  let(:post_struct) { Types::Post.new(title: "Testing 123", status: Types::PostStatus::Draft) }
  let(:location_model) { Location.new(name: "Florida") }
  let(:location_struct) { Types::Location.new(name: "Florida") }

  describe "#eject" do
    context "when T::Struct contains simple fields" do
      it "converts from ActiveRecord model" do
        expect(location_model.eject).to eq(location_struct)
      end
    end

    context "when Sorbet struct contains T::Enum field" do
      it "converts from ActiveRecord model" do
        expect(post_model.eject).to eq(post_struct)
      end
    end

    context "when Sorbet struct contains T::Struct field" do
      it "converts from ActiveRecord model, using association" do
        expect(user_model.eject).to eq(user_struct)
      end
    end
  end

  describe "#to_struct" do
    it "is an alias for #eject" do
      expect(user_model.to_struct).to eq(user_struct)
    end
  end

  describe ".buckle" do
    context "when T::Struct contains simple fields" do
      it "converts into ActiveRecord model" do
        new_user = User.buckle(user_struct)

        expect(new_user).to be_a(User)
        expect(new_user.name).to eq("Max")
        expect(new_user.age).to eq(28)
      end
    end

    context "when T::Struct contains T::Enum field" do
      it "converts into ActiveRecord model" do
        new_post = Post.buckle(post_struct)

        expect(new_post).to be_a(Post)
        expect(new_post.title).to eq("Testing 123")
        expect(new_post.status).to eq("draft")
      end
    end

    context "when invalid class is passed in" do
      it "raises an ArgumentError" do
        pet = Types::Pet.new(name: "Java", breed: "Long-haired Cat")

        expect { User.buckle(pet) }.to raise_error(ArgumentError)
      end
    end
  end

  describe ".from_struct" do
    it "is an alias for .buckle" do
      new_user = User.from_struct(user_struct)

      expect(new_user).to be_a(User)
      expect(new_user.name).to eq("Max")
      expect(new_user.age).to eq(28)
    end
  end
end
