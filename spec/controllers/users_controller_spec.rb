require "rails_helper"

describe UsersController, type: :controller do
	let (:user) {User.create!(email: "spec@test.com", password: "passwordtest")}
	let (:user_2) {User.create!(email: "spec_user2@test.com", password: "passwordtest2")}

	describe "GET #show" do

		context "when user is logged in" do
			before do
				sign_in user
			end

			it "loads correct user details" do
				get :show, params: {id: user.id}
				expect(response).to be_ok
				expect(assigns(:user)).to eq user
			end

			it "restricts access to other users" do
				get :show, params: {id: user_2.id}
				expect(response).to have_http_status(302)
				expect(response).to redirect_to(root_path)
			end
		end

		context "when user is not logged in" do
			it "redirects to login" do
				get :show, params: {id: user.id}
				expect(response).to redirect_to(new_user_session_path)
			end
		end

	end
end