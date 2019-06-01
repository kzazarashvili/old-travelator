require 'rails_helper'

RSpec.describe TripsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:trip) { create(:trip, user: user) }
  let!(:valid_attributes) { attributes_for(:trip, :valid) }
  let!(:invalid_attributes) { attributes_for(:trip, :invalid) }

  before(:each) { sign_in(user) }

  describe 'GET #index' do
    before(:each) { get :index }

    it { expect(assigns(:trips)).not_to be_empty }
    it { expect(assigns(:trips).count).to eq(1) }
    it { expect(assigns(:trips)).to include(trip) }
    it { expect(response).to render_template :index }
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Trip' do
        expect {
          post :create, xhr: true, format: :js, params: { trip: valid_attributes }
       }.to change(Trip, :count).by(1)
      end

      it 'assigns a newly created trip as @trip' do
        post :create, xhr: true, format: :js, params: { trip: valid_attributes }
        expect(assigns(:trip)).to be_a(Trip)
        expect(assigns(:trip)).to be_persisted
        expect(response).to render_template(:create)
      end
    end

    context 'with invalid params' do
      before { post :create, xhr: true, format: :js, params: { trip: invalid_attributes } }

      it { expect(assigns(:trip)).to be_a(Trip) }
      it { expect(assigns(:trip)).not_to be_persisted }
      it { expect(response).to render_template(:new) }
    end
  end

  describe 'GET #edit' do
    before(:each) { get :edit, xhr: true, format: :js, params: { id: trip.to_param } }

    it { expect(assigns(:trip)).to eq(trip) }
    it { expect(response).to render_template(:edit) }
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let!(:new_valid_attributes) { attributes_for(:trip, :new) }

      before(:each) { put :update, xhr: true, format: :js, params: { id: trip.to_param, trip: new_valid_attributes } }

      it 'update a trip with validation' do
        assigns(:trip).reload
        expect(assigns(:trip).ended_at).to eq new_valid_attributes[:ended_at]
      end

      it { expect(assigns(:trip)).to eq(trip) }
      it { expect(response).to render_template(:update) }
    end

    context 'with invalid params' do
      before { put :update, xhr: true, format: :js, params: { id: trip.to_param, trip: invalid_attributes } }

      it 'invalid update of trip' do
        assigns(:trip).reload
        expect(assigns(:trip).started_at).not_to eq(invalid_attributes[:started_at])
      end

      it { expect(assigns(:trip)).to eq(trip) }
      it { expect(response).to render_template(:edit) }
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested trip' do
      expect {
        delete :destroy, xhr: true, format: :js, params: { id: trip.to_param }
      }.to change(Trip, :count).by(-1)
    end

    it 'assigns a trip to delete as @trip' do
      delete :destroy, xhr: true, format: :js, params: { id: trip.to_param }

      expect(assigns(:trip)).to eq(trip)
      expect(response).to render_template(:destroy)
    end
  end
end
