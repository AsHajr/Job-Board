class Job < ApplicationRecord
    
    include Filterable

    has_many :jobapps, dependent: :destroy

    validates_presence_of :title, :created_by, :description
    
    scope :filter_by_title, -> (title) {where("title like ?", "#{title}%") }
    scope :filter_by_created_at, -> (created_at) {where(created_at: created_at.to_s)}

end
