require 'rails_helper'

RSpec.describe "Receipts", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/receipts/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /print" do
    it "returns http success" do
      get "/receipts/print"
      expect(response).to have_http_status(:success)
    end
  end
end
