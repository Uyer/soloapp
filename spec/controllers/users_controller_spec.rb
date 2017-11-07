require "rails_helper"

describe UsersController, type: :controller do
	#let (:user) {User.create!(email: "spec@test.com", password: "passwordtest")}
	before do
		@user1 = FactoryGirl.create(:user)
		@user2 = FactoryGirl.create(:user)
	end
	
	describe "GET #show" do

		context "when user is logged in" do
			before do
				sign_in @user1
			end

			it "loads correct user details" do
				get :show, params: {id: @user1.id}
				expect(response).to be_ok
				expect(assigns(:user)).to eq @user1
			end

			it "restricts access to other users" do
				get :show, params: {id: @user2.id}
				expect(response).to have_http_status(302)
				expect(response).to redirect_to(root_path)
			end
		end

		context "when user is not logged in" do
			it "redirects to login" do
				get :show, params: {id: @user1.id}
				expect(response).to redirect_to(new_user_session_path)
			end
		end

	end
end