require 'rails_helper'

describe Task, type: :model do
  subject { build(:task) }

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should belong_to(:list) }
  end
  
end
