# typed: false
# frozen_string_literal: true

class SchemaInfo < ActiveRecord::Base
  self.table_name = "schema_info"

  VERSION = 12
end
