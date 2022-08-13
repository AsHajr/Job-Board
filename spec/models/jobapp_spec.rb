require 'rails_helper'

RSpec.describe Jobapp, type: :model do

  it { should belong_to(:job) }

  it { should validate_presence_of(:created_by) }
  
end
