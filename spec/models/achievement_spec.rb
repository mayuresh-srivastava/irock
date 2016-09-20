require 'rails_helper'

RSpec.describe Achievement, type: :model do

  describe 'validations' do

    # it 'requires title' do
    #   achievement = Achievement.new(title: '')
    #   achievement.valid?
    #   expect(achievement.valid?).to be_falsy
    # end

    it { should validate_presence_of(:title) }

    # it 'requires title to be unique for one user' do
    #   user = FactoryGirl.create(:user)
    #   first_achievement = FactoryGirl.create(:public_achievement, title: 'First Achievement', user: user)
    #   new_achievement = Achievement.new(title: 'First Achievement', user: user)
    #   expect(new_achievement.valid?).to be_falsy	
    # end 

    # it 'allows different users to have achievements with identical titles' do
    #   user1 = FactoryGirl.create(:user)
    #   user2 = FactoryGirl.create(:user)
    #   first_achievement = FactoryGirl.create(:public_achievement, title: 'First Achievement', user: user1)
    #   new_achievement = Achievement.new(title: 'First Achievement', user: user2)
    #   expect(new_achievement.valid?).to be_truthy
    # end

    #it { should validate_uniqueness_of(:title).case_insensitive.scoped_to(:user_id).with_message("you can't have two achievements with same title") }	

    # it 'belongs to user' do
    #   achievement = Achievement.new(title: 'Some title', user: nil)
    #   expect(achievement.valid?).to be_falsey
    # end

    it { should validate_presence_of(:user) }
    
    # it 'has belongs_to user assiciation' do
    # # 1 Approach	
    #   user = FactoryGirl.create(:user)
    #   achievement = FactoryGirl.create(:public_achievement, user: user)
    #   expect(achievement.user).to eq(user)

    # # 2 Approach
    #   u = Achievement.reflect_on_association(:user)
    #   expect(u.macro).to eq(:belongs_to) 
    # end
 
    it { should belong_to(:user) }
    it { should have_many(:encouragements) }

    it 'converts markdown to html' do
      achievement = Achievement.new(description: 'Awesome **thing** I *actually* did')
      expect(achievement.description_html).to include('<strong>thing</strong>')
      expect(achievement.description_html).to include('<em>actually</em>')
    end

    it 'has silly title' do
      achievement = Achievement.new(title: "New Achievement", user: FactoryGirl.create(:user, email: 'test@test.com'))
      expect(achievement.silly_title).to eq('New Achievement by test@test.com')
    end

    it 'only fetches achievements which title starts from provided letter' do
      user = FactoryGirl.create(:user)
      achievement1 = FactoryGirl.create(:public_achievement, title: 'Read a book', user: user)
      achievement2 = FactoryGirl.create(:public_achievement, title: 'Passed an exam', user: user)
      expect(Achievement.by_letter("R")).to eq([achievement1])
    end

    it 'sorts achievements by user emails' do
      albert = FactoryGirl.create(:user, email: 'albert@email.com')
      rob = FactoryGirl.create(:user, email: 'rob@email.com')
      achievement1 = FactoryGirl.create(:public_achievement, title: 'Read a book', user: rob)
      achievement2 = FactoryGirl.create(:public_achievement, title: 'Rocked it', user: albert)
      expect(Achievement.by_letter("R")).to eq([achievement2, achievement1]) 
    end

  end
end
