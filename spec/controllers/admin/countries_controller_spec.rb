require 'rails_helper'

RSpec.describe Admin::CountriesController, type: :controller do
  let!(:admin) { create(:user, :admin) }
  let!(:country) { create(:country) }
  let!(:valid_attributes) { attributes_for(:country, :valid_country) }
  let!(:invalid_attributes) { attributes_for(:country, :invalid_country) }

  before(:each) { sign_in(admin) }

  describe 'GET #index' do
    before(:each) { get :index }

    it { expect(assigns(:countries)).not_to be_empty }
    it { expect(assigns(:countries).count).to eq(1) }
    it { expect(assigns(:countries)).to include(country) }
    it { expect(response).to render_template :index }
  end

  describe 'GET #show' do
    before(:each) { get :show, params: { id: country.to_param } }

    it { expect(assigns(:country)).to eq(country) }
    it { expect(response).to render_template(:show) }
  end

  describe 'GET #new' do
    before(:each) { get :new }

    it { expect(assigns(:country)).to be_a_new(Country) }
    it { expect(response).to render_template :new }
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new Country' do
        expect {
          post :create, params: { country: valid_attributes }
        }.to change(Country, :count).by(1)
      end

      before(:each) { post :create, params: { country: valid_attributes } }

      it { expect(assigns(:country)).to be_a(Country) }
      it { expect(assigns(:country)).to be_persisted }
      it { expect(response).to redirect_to([:admin, assigns(:country)]) }
    end

    context 'with invalid attributes' do
      before(:each) { post :create, params: { country: invalid_attributes } }

      it 'does not create a new Country' do
       expect {
         post :create, params: { country: invalid_attributes }
       }.to change(Country, :count).by(0)
     end

      it { expect(assigns(:country)).to be_a(Country) }
      it { expect(assigns(:country)).not_to be_persisted }
      it { expect(response).to render_template(:new) }
    end
  end

  describe 'GET #edit' do
    before(:each) { get :edit, params: { id: country.to_param } }

    it { expect(assigns(:country)).to eq(country) }
    it { expect(response).to render_template(:edit) }
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      let!(:new_valid_attributes) { attributes_for(:country, :new_name) }

      before(:each) { put :update, params: { id: country.to_param, country: new_valid_attributes } }

      it 'updates country name according to new attributes' do
        country.reload
        expect(country.name).to eq new_valid_attributes[:name]
      end

      it { expect(assigns(:country)).to eq(country) }
      it { expect(response).to redirect_to([:admin, country]) }
    end

    context 'with invalid attributes' do
      before { put :update, params: { id: country.to_param, country: invalid_attributes } }

      it 'does not update country name with invalid attributes' do
        country.reload
        expect(country.name).not_to eq(invalid_attributes[:name])
      end

      it { expect(assigns(:country)).to eq(country) }
      it { expect(response).to render_template(:edit) }
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested country' do
      expect {
        delete :destroy, params: { id: country.to_param }
      }.to change(Country, :count).by(-1)
    end

    it 'aassigns country to @country and checks redirection to correct path' do
      delete :destroy, params: { id: country.to_param }

      expect(assigns(:country)).to eq(country)
      expect(response).to redirect_to(admin_countries_path)
    end
  end
end
