# frozen_string_literal: true

class User < ActiveRecord::Base
  ejects_to Types::User
end
