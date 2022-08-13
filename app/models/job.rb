class Job < ApplicationRecord
    has_many :jobapps, dependent: :destroy

    validates_presence_of :title, :created_by, :description
end
