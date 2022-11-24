class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  before_create { self.id = ULID.generate.encode }
end
