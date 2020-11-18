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

  describe 'GET #show' do
    it "showアクションにリクエストすると正常にレスポンスが返ってくる" do 
      get review_path(@review)
      expect(response.status).to eq 200
    end

    it 'showアクションにリクエストするとレスポンスにレビューの投稿者名が表示されている' do
      get review_path(@review)
      expect(response.body).to include @review.user.nickname
    end

    it 'showアクションにリクエストするとレスポンスに商品名が表示されている' do
      get review_path(@review)
      expect(response.body).to include @review.manufacture.name
    end

    it 'showアクションにリクエストするとレスポンスにラバーの種類が表示されている' do
      get review_path(@review)
      expect(response.body).to include @review.type.name
    end

    it 'showアクションにリクエストするとレスポンスに打球感が表示されている' do
      get review_path(@review)
      expect(response.body).to include @review.hardness.name
    end

    it 'showアクションにリクエストするとレスポンスに価格が表示されている' do
      get review_path(@review)
      expect(response.body).to include @review.price.to_s
    end

    it 'showアクションにリクエストするとレスポンスにスピード性能の点数が表示されている' do
      get review_path(@review)
      expect(response.body).to include @review.speed.name
    end

    it 'showアクションにリクエストするとレスポンスにスピン性能の点数が表示されている' do
      get review_path(@review)
      expect(response.body).to include @review.spin.name
    end

    it 'showアクションにリクエストするとレスポンスにコントロール性能の点数が表示されている' do
      get review_path(@review)
      expect(response.body).to include @review.control.name
    end

    it 'showアクションにリクエストするとレスポンスに総合評価の点数が表示されている' do
      get review_path(@review)
      expect(response.body).to include @review.evaluation.name
    end

    it 'showアクションにリクエストするとレスポンスにその他コメントが表示されている' do
      get review_path(@review)
      expect(response.body).to include @review.content
    end
  end
end
