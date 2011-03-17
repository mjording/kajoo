require 'spec_helper'

describe Issue do
  it { should belong_to(:creator)}

  describe "#add_vote_for_user" do
    let(:issue){ Fabricate.build :issue}
    subject { issue }
    let(:user){ Fabricate :user }
    it do
      expect { subject.add_vote_for_user(user) }.to change(IssueVote, :count).by(1)
    end
  end
  #describe ".find_similar" do
    #context 'when passed a report' do
      #let(:report){ Fabricate :report}
      #subject { described_class.find_similar(report) }

      #it { should_not be_blank }
    #end
  #end


end



# == Schema Information
#
# Table name: issues
#
#  id             :integer(4)      not null, primary key
#  title          :string(255)
#  description    :text
#  lat            :float
#  lon            :float
#  radius         :integer(4)
#  created_at     :datetime
#  updated_at     :datetime
#  address        :string(255)
#  resolved       :boolean(1)
#  ip_address     :string(255)
#  location       :text
#  city           :string(255)
#  state          :string(255)
#  country_code   :string(255)
#  country_name   :string(255)
#  street_address :string(255)
#  zipcode        :string(255)
#  vote_count     :integer(4)      default(0)
#  resolved_at    :datetime
#  resolver_id    :integer(4)
#  creator_id     :integer(4)
#

