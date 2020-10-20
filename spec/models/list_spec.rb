require 'rails_helper'

describe List, type: :model do
  subject { build(:list) }

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should belong_to(:user) }
    it { should have_many(:tasks) }
  end
end
