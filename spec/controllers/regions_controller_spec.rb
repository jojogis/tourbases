require 'rails_helper'

RSpec.describe RegionsController do
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
    region = Region.all.first
    it 'has a 200 status code' do
      get :edit, params: { id: region.id }
      expect(response.status).to eq(200)
    end
    it 'has renders edit template' do
      get :edit, params: { id: region.id }
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
      region = Region.all.first
      delete :destroy, params: { id: region.id }
      expect(response.status).to eq(302)
    end
    it 'deleting region' do
      region = Region.all.first
      region_id = region.id
      delete :destroy, params: { id: region_id }
      expect(Region.find_by(id: region_id).nil?).to eq true
    end
    it 'redirects to index page' do
      region = Region.all.first
      region_id = region.id
      delete :destroy, params: { id: region_id }
      expect(response).to be_redirect
      expect(response).to redirect_to regions_path
    end
  end

  describe 'PATCH update' do
    region = Region.all.last
    it 'has a 302 status code' do
      patch :update, params: { id: region.id, region: { name: 'new name' } }
      expect(response.status).to eq(302)
    end
    it 'updates region' do
      patch :update, params: { id: region.id, region: { name: 'new name' } }
      expect(Region.find(region.id).name).to eq('new name')
    end
    it 'redirects to index page' do
      patch :update, params: { id: region.id, region: { name: 'new name' } }
      expect(response).to be_redirect
      expect(response).to redirect_to regions_path
    end
    it 'has 422 status code when send invalid name' do
      patch :update, params: { id: region.id, region: { name: 'n' } }
      expect(response.status).to eq(422)
    end
    it 'has 422 status code when send invalid country id' do
      patch :update, params: { id: region.id, region: { country_id: nil } }
      expect(response.status).to eq(422)
    end
    it 'renders edit template when send invalid data' do
      patch :update, params: { id: region.id, region: { name: 'n', country_id: nil } }
      expect(response).to render_template('edit')
    end
  end

  describe 'POST create' do
    country = Country.all.first
    it 'has 302 status code' do
      post :create, params: { region: { name: 'new region', country_id: country.id } }
      expect(response.status).to eq(302)
    end
    it 'creates region' do
      region_name = "new region #{Time.now}"
      post :create, params: { region: { name: region_name, country_id: country.id } }
      expect(Region.find_by(name: region_name).nil?).to eq false
    end
    it 'redirects to index page' do
      post :create, params: { region: { name: 'new region', country_id: country.id } }
      expect(response).to be_redirect
      expect(response).to redirect_to regions_path
    end
    it 'has 422 status code when send invalid name' do
      post :create, params: { region: { name: 'n', country_id: country.id } }
      expect(response.status).to eq(422)
    end
    it 'has 422 status code when send invalid country id' do
      post :create, params: { region: { name: 'new region', country_id: nil } }
      expect(response.status).to eq(422)
    end
    it 'renders new template when send invalid data' do
      post :create, params: { region: { name: 'n', country_id: nil } }
      expect(response).to render_template('new')
    end
  end

end
