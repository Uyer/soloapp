require "rails_helper"

describe ProductsController, type: :controller do

	before do 
		@user = FactoryBot.create(:user)
		@admin = FactoryBot.create(:admin)
		@product1 = FactoryBot.create(:product, name: "Result", description: "Searchable", price: 22.5)
		@product2 = FactoryBot.create(:product)
		@product3 = FactoryBot.create(:product)
	end

	# index action

	describe 'GET #index' do

		context "when search is committed" do

			it "returns products that match the search term" do
				get :index, params: {q: "Result"}
				expect(assigns(:products)).to match_array([@product1])
			end

			it "renders the index page" do
				get :index
				expect(response).to be_ok
				expect(response).to render_template("index")
			end

		end

		context "when no search is committed" do

			it "returns index of all products" do
				get :index
				expect(assigns(:products)).to match_array([@product1, @product2, @product3])
			end

			it "renders the index page" do
				get :index
				expect(response).to be_ok
				expect(response).to render_template("index")
			end

		end

	end
	

	# show action
	context "GET #show" do
		it "renders the show page" do
			get :show, params: {id: @product1}
			expect(response).to be_ok
			expect(response).to render_template("show")
		end
	end

	# new action
	describe "GET #new" do

		context "User is admin" do
			before do
				sign_in @admin
			end

			it "renders the new page to admin" do
				get :new
				expect(response).to be_ok
			end

		end

		context "User is not admin" do
			before do
				sign_in @user
			end

			it "Restricts access to #new page for non-admin" do
				get :new
				expect(response).not_to be_ok
				expect(response).to redirect_to(root_path)
				expect(flash[:alert]).to eq "You are not authorized to access this page."
			end

		end

		context "User is not logged in" do
			
			it "Restricts access to #new page" do
				get :new
				expect(response).not_to be_ok
				expect(response).to redirect_to(root_path)
				expect(flash[:alert]).to eq "You are not authorized to access this page."
			end

		end

	end
	

	# edit action

	describe "GET #edit" do

		context "User is admin" do
			before do
				sign_in @admin
			end

			it "renders the edit page to admin" do
				get :edit, params: {id: @product1}
				expect(response).to be_ok
			end

		end

		context "User is not admin" do
			before do
				sign_in @user
			end

			it "Restricts access to #edit page for non-admin" do
				get :edit, params: {id: @product1}
				expect(response).not_to be_ok
				expect(response).to redirect_to(root_path)
				expect(flash[:alert]).to eq "You are not authorized to access this page."
			end

		end

		context "User is not logged in" do
			
			it "Restricts access to #edit page" do
				get :edit, params: {id: @product1}
				expect(response).not_to be_ok
				expect(response).to redirect_to(root_path)
				expect(flash[:alert]).to eq "You are not authorized to access this page."
			end

		end

	end

	# create action
	describe "POST #create" do

		context "User is admin" do
			before do
				sign_in @admin
			end

			it "Creates a new product as admin" do
				expect {
					post :create, params: {product: attributes_for(:product)}
				}.to change(Product, :count).by(1)
				expect(response).to redirect_to product_path(assigns[:product])
				expect(flash[:notice]).to eq "Product was successfully created."
			end

		end

		context "User is not admin" do
			before do
				sign_in @user
			end

			it "Cannot create a new product" do
				post :create , params: {product: attributes_for(:product)}
				expect(response).to have_http_status(302)
				expect(response).to redirect_to(root_path)
				expect(flash[:alert]).to eq "You are not authorized to access this page."
			end

		end

		context "User is not logged in" do

			it "Cannot create a new product" do
				post :create , params: {product: attributes_for(:product)}
				expect(response).to have_http_status(302)
				expect(response).to redirect_to(root_path)
				expect(flash[:alert]).to eq "You are not authorized to access this page."
			end

		end

	end

	# update action

	describe "PATCH #update" do

		context "when admin user updates a product" do

			before do
				sign_in @admin
			end

			it "saves the product to the database" do
				patch :update, params: {id: @product1.id, product: {name: "Updated"}}
				expect(Product.where("id = ?", @product1.id).first.name).to eq "Updated"
				expect(response.status).to eq 302
				expect(response).to redirect_to @product
				expect(flash[:notice]).to eq "Product was successfully updated."
				expect(Product.count).to eq 3				
			end
		end

		context "when admin user updates a product with non valid value" do

			before do
				sign_in @admin
			end

			it "does not update the product" do
				patch :update, params: {id: @product1.id, product: {name: ""}}
				expect(Product.where("id = ?", @product1.id).first.name).to eq @product1.name
				expect(response.status).to eq 200
				expect(Product.count).to eq 3				
			end
		end

		context "when user is not admin" do

			before do
				sign_in @user
			end

			it "does not update the product" do
				patch :update, params: {id: @product1.id, product: {name: "Updated"}}
				expect(Product.where("id = ?", @product1.id).first.name).to eq @product1.name
				expect(response.status).to eq 302
				expect(flash[:alert]).to eq "You are not authorized to access this page."
				expect(Product.count).to eq 3				
			end
		end

		context "when user is not logged in" do

			it "does not update the product" do
				patch :update, params: {id: @product1.id, product: {name: "Updated"}}
				expect(Product.where("id = ?", @product1.id).first.name).to eq @product1.name
				expect(response.status).to eq 302
				expect(flash[:alert]).to eq "You are not authorized to access this page."
				expect(Product.count).to eq 3				
			end
		end

	end


	# destroy action

	describe "DELETE #destroy" do

		context "when user is admin" do

			before do
				sign_in @admin
			end

			it "deletes the product" do
				delete :destroy, params: {id: @product1.id}
				expect(response.status).to eq 302
				expect(response).to redirect_to products_path
				expect(flash[:notice]).to eq "Product was successfully destroyed."
				expect(Product.where("id = ?", @product1.id)).not_to exist
				expect(Product.count).to eq 2
			end

		end

		context "where user is not admin" do

			before do 
				sign_in @user
			end

			it "does not delete the product" do
				delete :destroy, params: {id: @product1.id}
				expect(response.status).to eq 302
				expect(response).to redirect_to root_path
				expect(Product.where("id = ?", @product1.id)).to exist
				expect(Product.count).to eq 3
			end

		end

		context "where user is not logged in" do

			it "does not delete the product" do
				delete :destroy, params: {id: @product1.id}
				expect(response.status).to eq 302
				expect(response).to redirect_to root_path
				expect(Product.where("id = ?", @product1.id)).to exist
				expect(Product.count).to eq 3
			end
			
		end

	end
	
end