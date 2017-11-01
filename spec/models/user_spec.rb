require 'rails_helper'
describe User do
  context "test validations" do
    
    it "not valid without email" do
      expect(User.new(first_name: "Mario", last_name: "Totoro", email: nil)).not_to be_valid
    end

  end
end