class Job < ApplicationRecord
    
    include Filterable

    # model association
    has_many :jobapps, dependent: :destroy

    # validations
    validates_presence_of :title, :created_by, :description
    
    # filters
    scope :filter_by_title, -> (title) {where("title like ?", "#{title}%") }
    scope :filter_by_created_at, -> (created_at) {where(created_at: created_at.to_s)}

end
