require 'rails_helper'

describe Comment do

  context "comment validation" do
    it "requires rating" do
      expect(Comment.new(rating: nil)).not_to be_valid
    end
  end

end
