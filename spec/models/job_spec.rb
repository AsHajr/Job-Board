require 'rails_helper'

RSpec.describe Job, type: :model do

  it { should have_many(:jobapps).dependent(:destroy) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:created_by) }

end
