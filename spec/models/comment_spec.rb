require 'rails_helper'

describe Comment do
  
  context "when comment has no body" do
    product = FactoryBot.build(:product)
    user = FactoryBot.build(:user)
    
    before do 
      (Comment.new(user: user, rating: 5))
    end

    it "is not valid" do
      expect(Comment.new).not_to be_valid
    end
  end

  context "when comment without user" do
    product = FactoryBot.build(:product)
    user = FactoryBot.build(:user)

    before do
      (Comment.new(body: "test body", rating: 5))
    end

    it "is not valid" do
      expect(Comment.new).not_to be_valid
    end
  end

  context "when comment has no rating" do
  
    product = FactoryBot.build(:product)
    user = FactoryBot.build(:user)
    
    before do
        (Comment.new(user: user, body: "test body"))
    end

      it "is not valid" do
        expect(Comment.new).not_to be_valid
      end
    end
      context "when comment rating is not a number" do
      
        product = FactoryBot.build(:product)
        user = FactoryBot.build(:user)

        before do
          (Comment.new(user: user, body: "test body", rating: "five"))
        end

        it "is not valid" do
          expect(Comment.new).not_to be_valid
        end
      end
end
