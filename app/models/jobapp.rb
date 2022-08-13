class Jobapp < ApplicationRecord

  belongs_to :job

  validates_presence_of :created_by
  
end
