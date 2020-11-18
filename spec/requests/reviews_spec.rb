require 'rails_helper'
describe ReviewsController, type: :request do
  before do
    @review = FactoryBot.build(:review)
    @review.image = fixture_file_upload('public/images/test.jpg')
    @review.save
  end

  describe 'GET #index' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      get root_path
      expect(response.status).to eq 200
    end

    it 'indexアクションにリクエストするとレスポンスに投稿済みのレビューの商品名が表示されている' do
      get root_path
      expect(response.body).to include @review.name
    end

    it 'indexアクションにリクエストするとレスポンスに投稿済みのレビューの投稿者名が表示されている' do
      get root_path
      expect(response.body).to include @review.user.nickname
    end

    it 'indexアクションにリクエストするとレスポンスに投稿済みのレビューのメーカー名が表示されている' do
      get root_path
      expect(response.body).to include @review.manufacture.name
    end

    it 'indexアクションにリクエストするとレスポンスに投稿済みのレビューの総合評価点数が表示されている' do
      get root_path
      expect(response.body).to include @review.evaluation.name
    end
  end
end
