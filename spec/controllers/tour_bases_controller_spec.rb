require 'rails_helper'

RSpec.describe TourBasesController do
  describe 'GET index' do
    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end
    it 'has renders index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET edit' do
    tour_base = TourBase.all.first
    it 'has a 200 status code' do
      get :edit, params: { id: tour_base.id }
      expect(response.status).to eq(200)
    end
    it 'has renders edit template' do
      get :edit, params: { id: tour_base.id }
      expect(response).to render_template('edit')
    end
  end

  describe 'GET new' do
    it 'has a 200 status code' do
      get :new
      expect(response.status).to eq(200)
    end
    it 'has renders new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'DELETE destroy' do
    it 'has a 302 status code' do
      tour_base = TourBase.all.first
      delete :destroy, params: { id: tour_base.id }
      expect(response.status).to eq(302)
    end
    it 'deleting region' do
      tour_base = TourBase.all.first
      tour_base_id = tour_base.id
      delete :destroy, params: { id: tour_base_id }
      expect(TourBase.find_by(id: tour_base_id).nil?).to eq true
    end
    it 'redirects to index page' do
      tour_base = TourBase.all.first
      tour_base_id = tour_base.id
      delete :destroy, params: { id: tour_base_id }
      expect(response).to be_redirect
      expect(response).to redirect_to tour_bases_path
    end
  end

  describe 'PATCH update' do
    tour_base = TourBase.all.last
    it 'has a 302 status code' do
      patch :update, params: { id: tour_base.id, tour_base: { name: 'new name' } }
      expect(response.status).to eq(302)
    end
    it 'updates country' do
      patch :update, params: { id: tour_base.id, tour_base: { name: 'new name' } }
      expect(TourBase.find(tour_base.id).name).to eq('new name')
    end
    it 'redirects to index page' do
      patch :update, params: { id: tour_base.id, tour_base: { name: 'new name' } }
      expect(response).to be_redirect
      expect(response).to redirect_to tour_bases_path
    end
    it 'has 422 status code when send invalid name' do
      patch :update, params: { id: tour_base.id, tour_base: { name: 'n' } }
      expect(response.status).to eq(422)
    end
    it 'has 422 status code when send invalid region id' do
      patch :update, params: { id: tour_base.id, tour_base: { name: 'new tour base', region_id: nil } }
      expect(response.status).to eq(422)
    end
    it 'renders edit template when send invalid data' do
      patch :update, params: { id: tour_base.id, tour_base: { name: 'n', region_id: nil } }
      expect(response).to render_template('edit')
    end
  end

  describe 'POST create' do
    region = Region.all.first
    it 'has 302 status code' do
      post :create, params: { tour_base: { name: 'new tour base', region_id: region.id } }
      expect(response.status).to eq(302)
    end
    it 'creates tour base' do
      tour_base_name = "new tour base #{Time.now}"
      post :create, params: { tour_base: { name: tour_base_name, region_id: region.id } }
      expect(TourBase.find_by(name: tour_base_name).nil?).to eq false
    end
    it 'redirects to index page' do
      post :create, params: { tour_base: { name: 'new tour base', region_id: region.id } }
      expect(response).to be_redirect
      expect(response).to redirect_to tour_bases_path
    end
    it 'has 422 status code when send invalid name' do
      post :create, params: { tour_base: { name: 'n', region_id: region.id } }
      expect(response.status).to eq(422)
    end
    it 'has 422 status code when send invalid region id' do
      post :create, params: { tour_base: { name: 'new tour base', region_id: nil } }
      expect(response.status).to eq(422)
    end
    it 'renders new template when send invalid data' do
      post :create, params: { tour_base: { name: 'n', region_id: nil } }
      expect(response).to render_template('new')
    end
  end
end
