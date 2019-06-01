require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  let!(:admin) { create(:user, :admin) }
  let!(:user) { create(:user) }

  before(:each) { sign_in(admin) }

  describe 'GET #index' do
    before(:each) { get :index }

    it { expect(assigns(:users)).not_to be_empty }
    it { expect(assigns(:users).count).to eq(1) }
    it { expect(assigns(:users)).to include(user) }
    it { expect(response).to render_template(:index) }
  end

  describe 'GET #show' do
    before(:each) { get :show, params: { id: user.to_param } }

    it { expect(assigns(:user)).to eq(user) }
    it { expect(response).to render_template(:show) }
  end

  describe 'GET #edit' do
    before(:each) { get :edit, params: { id: user.to_param } }

    it { expect(assigns(:user)).to eq(user) }
    it { expect(response).to render_template(:edit) }
  end

  describe 'PUT #update' do
    let!(:admin_attributes) { attributes_for(:user, :admin) }

    before(:each) { put :update, params: { id: user.to_param, user: admin_attributes } }

    it { expect(assigns(:user)).to eq(user) }

    it 'makes sure the user becomes admin' do
      user.reload
      expect(user.admin?).to be_truthy
    end

    it { expect(response).to redirect_to([:admin, user]) }
  end
end
