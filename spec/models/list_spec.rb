require 'rails_helper'

describe List, type: :model do
  subject { build(:list) }

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should belong_to(:user) }
    it { should have_many(:tasks) }
  end

  describe '#percentage_done' do
    before { subject.save }

    let!(:first_task) { create(:task, description: 'buy bread', list: subject, task_check: true) }
    let!(:second_task) { create(:task, description: 'buy basmati', list: subject) }

    it "should return the percentage of the checked tasks" do
       expect(subject.percentage_done).to eq(50)
    end
  end
end
