require 'rails_helper'

RSpec.describe CountriesController do
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
    country = Country.all.first
    it 'has a 200 status code' do
      get :edit, params: { id: country.id }
      expect(response.status).to eq(200)
    end
    it 'has renders edit template' do
      get :edit, params: { id: country.id }
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
      country = Country.all.first
      delete :destroy, params: { id: country.id }
      expect(response.status).to eq(302)
    end
    it 'deleting country' do
      country = Country.all.first
      country_id = country.id
      delete :destroy, params: { id: country_id }
      expect(Country.find_by(id: country_id).nil?).to eq true
    end
    it 'redirects to index page' do
      country = Country.all.first
      country_id = country.id
      delete :destroy, params: { id: country_id }
      expect(response).to be_redirect
      expect(response).to redirect_to countries_path
    end
  end

  describe 'PATCH update' do
    country = Country.all.last
    it 'has a 302 status code' do
      patch :update, params: { id: country.id, country: { name: 'new name' } }
      expect(response.status).to eq(302)
    end
    it 'updates country' do
      patch :update, params: { id: country.id, country: { name: 'new name' } }
      expect(Country.find(country.id).name).to eq('new name')
    end
    it 'redirects to index page' do
      patch :update, params: { id: country.id, country: { name: 'new name' } }
      expect(response).to be_redirect
      expect(response).to redirect_to countries_path
    end
    it 'has 422 status code when send invalid name' do
      patch :update, params: { id: country.id, country: { name: 'n' } }
      expect(response.status).to eq(422)
    end
    it 'renders edit template when send invalid data' do
      patch :update, params: { id: country.id, country: { name: 'n' } }
      expect(response).to render_template('edit')
    end
  end
  describe 'POST create' do
    it 'has 302 status code' do
      post :create, params: { country: { name: 'new country' } }
      expect(response.status).to eq(302)
    end
    it 'creates country' do
      country_name = "new country #{Time.now}"
      post :create, params: { country: { name: country_name } }
      expect(Country.find_by(name: country_name).nil?).to eq false
    end
    it 'redirects to index page' do
      post :create, params: { country: { name: 'new country' } }
      expect(response).to be_redirect
      expect(response).to redirect_to countries_path
    end
    it 'has 422 status code when send invalid name' do
      post :create, params: { country: { name: 'n' } }
      expect(response.status).to eq(422)
    end
    it 'renders new template when send invalid data' do
      post :create, params: { country: { name: 'n' } }
      expect(response).to render_template('new')
    end
  end
end
