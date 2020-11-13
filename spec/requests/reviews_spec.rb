require 'rails_helper'
describe ReviewsController, type: :request do
  before do
    @review = FactoryBot.build(:review)
    @review.image = fixture_file_upload('public/images/test.jpg')
  end

  describe "GET #index" do
  end
end