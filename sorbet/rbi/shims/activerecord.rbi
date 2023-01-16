# typed: true

class ActiveRecord::Base
  def self.reflect_on_all_associations; end

  def self.column_names; end
end
