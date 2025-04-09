require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET /menu" do
    it "returns http success" do
      get "/home/menu"
      expect(response).to have_http_status(:success)
    end
  end
end
