class Jobapp < ApplicationRecord
  
  # model association
  belongs_to :job

  # validation
  validates_presence_of :created_by
  
end
