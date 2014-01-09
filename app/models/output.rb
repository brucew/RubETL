class Output < ActiveRecord::Base
  extend BulkMethodsMixin

  validates_presence_of :role
end
