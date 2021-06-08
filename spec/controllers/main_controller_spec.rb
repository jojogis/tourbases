require 'rails_helper'

RSpec.describe MainController do
  describe 'GET index' do
    it 'has a 302 status code' do
      get :index
      expect(response.status).to eq(302)
    end
    it 'redirects to view/tour_bases' do
      get :index
      expect(response).to be_redirect
      expect(response).to redirect_to view_tour_bases_path
    end
  end
end