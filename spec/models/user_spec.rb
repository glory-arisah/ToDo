require 'rails_helper'

describe User, type: :model do
  subject { build(:user) }

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should have_many(:lists) } 
  end  
end