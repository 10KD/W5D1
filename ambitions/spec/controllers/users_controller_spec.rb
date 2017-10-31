require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #index" do
    it 'renders the new users template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "validates_presences of username and password" do
        post :create, params: { user: { username: "l", password: "" } }
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end

      it 'validates that the password is at least 6 characters long' do
        post :create, params: { user: { username: 'jack_bruce', password: 'short' } }
        expect(response).to render_template('new')
        expect(flash[:errors]).to be_present
      end
    end

    context "with valid params" do
      it "redirects the user's page" do
        # leo = User.new(username: 'l', password: 'asdfasd')
        post :create, params: { user: { username: "l", password: "asdfasd" } }

        expect(response).to redirect_to(user_url(User.last.id))
      end

      it 'logs in the user' do
        post :create, params: { user: { username: 'jack_bruce', password: 'password' } }
        user = User.find_by_username('jack_bruce')

        expect(session[:session_token]).to eq(user.session_token)
      end
    end
  end
end
