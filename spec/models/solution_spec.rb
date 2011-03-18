require 'spec_helper'

describe Solution do
 it { should belong_to(:user) }
 it { should belong_to(:issue) }
 it { should validate_presence_of(:title) }
 it { should validate_presence_of(:description) }

 describe "#add_vote_for_user" do
    let(:solution){ Fabricate.build :solution}
    subject { solution }
    let(:user){ Fabricate :user }
    it do
      expect { subject.add_vote_for_user(user) }.to change(SolutionVote, :count).by(1)
    end
  end

end


# == Schema Information
#
# Table name: solutions
#
#  id         :integer(4)      not null, primary key
#  title      :string(255)
#  user_id    :integer(4)
#  issue_id   :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

