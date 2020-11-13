require 'rails_helper'
describe ReviewsController, type: :request do
  before do
    @review = FactoryBot.build(:review)
    @review.image = fixture_file_upload('public/images/test.jpg')
    @review.save
  end

  describe "GET #index" do
    it "indexアクションにリクエストすると正常にレスポンスが返ってくる" do 
      get root_path
      expect(response.status).to eq 200
    end
  end
end