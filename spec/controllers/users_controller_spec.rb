require 'rails_helper'

describe UsersController, type: :controller do
  @user = { User.create!(email: 'totoron@gmail.com', password: 'testpassword')}
  @user2 = { User.create!(email: 'tongo@boboo.com', password: 'testpassword2')}
    
   describe "GET #show" do
     context 'when a user is logged in' do
        before do
          sign_in @user
        end

       it 'loads correct user details' do
          get :show, params: { id: @user.id }
          expect(response).to be_ok
          expect(assigns(:user)).to eq @user
        end

       it 'redirects to root path' do
          get :show, params: { id: @user2.id }
          expect(response).to redirect_to(root_path)
        end
     end
      
     context 'when a user is not logged in' do
        it 'redirects to login' do
          get :show, params: { id: @user.id }
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end