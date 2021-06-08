require 'rails_helper'

RSpec.describe CitiesController do
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
    city = City.all.first
    it 'has a 200 status code' do
      get :edit, params: { id: city.id }
      expect(response.status).to eq(200)
    end
    it 'has renders edit template' do
      get :edit, params: { id: city.id }
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
      city = City.all.first
      delete :destroy, params: { id: city.id }
      expect(response.status).to eq(302)
    end
    it 'deletes city' do
      city = City.all.first
      city_id = city.id
      delete :destroy, params: { id: city_id }
      expect(City.find_by(id: city_id).nil?).to eq true
    end
    it 'redirects to index page' do
      city = City.all.first
      city_id = city.id
      delete :destroy, params: { id: city_id }
      expect(response).to be_redirect
      expect(response).to redirect_to cities_path
    end
  end

  describe 'PATCH update' do
    city = City.all.last
    it 'has a 302 status code' do
      patch :update, params: { id: city.id, city: { name: 'new name', region_id: city.region_id } }
      expect(response.status).to eq(302)
    end
    it 'updates city' do
      patch :update, params: { id: city.id, city: { name: 'new name', region_id: city.region_id } }
      expect(City.find(city.id).name).to eq('new name')
    end
    it 'redirects to index page' do
      patch :update, params: { id: city.id, city: { name: 'new name', region_id: city.region_id } }
      expect(response).to be_redirect
      expect(response).to redirect_to cities_path
    end
    it 'has 422 status code when send invalid name' do
      patch :update, params: { id: city.id, city: { name: 'n' } }
      expect(response.status).to eq(422)
    end
    it 'has 422 status code when send invalid country id' do
      patch :update, params: { id: city.id, city: { name: 'new city', region_id: nil } }
      expect(response.status).to eq(422)
    end
    it 'renders edit template when send invalid data' do
      patch :update, params: { id: city.id, city: { name: 'n', region_id: nil } }
      expect(response).to render_template('edit')
    end
  end

  describe 'POST create' do
    region = Region.all.first
    it 'has 302 status code' do
      post :create, params: { city: { name: 'new city', region_id: region.id } }
      expect(response.status).to eq(302)
    end
    it 'creates city' do
      city_name = "new city #{Time.now}"
      post :create, params: { city: { name: city_name, region_id: region.id } }
      expect(City.find_by(name: city_name).nil?).to eq false
    end
    it 'redirects to index page' do
      post :create, params: { city: { name: 'new city', region_id: region.id } }
      expect(response).to be_redirect
      expect(response).to redirect_to cities_path
    end
    it 'has 422 status code when send invalid name' do
      post :create, params: { city: { name: 'n', region_id: region.id } }
      expect(response.status).to eq(422)
    end
    it 'has 422 status code when send invalid country id' do
      post :create, params: { city: { name: 'new city', region_id: nil } }
      expect(response.status).to eq(422)
    end
    it 'renders new template when send invalid data' do
      post :create, params: { city: { name: 'n', region_id: nil } }
      expect(response).to render_template('new')
    end
  end


end
