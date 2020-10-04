require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'レビューの新規投稿' do
    before do
      @review = FactoryBot.build(:review)
      @review.image = fixture_file_upload('public/images/test.jpg')
    end

    context 'レビューを投稿できる場合' do
      it 'image,name,manufacture_id,type_id,spin_id,speed_id,price,evaluation_id,content,control_id,hardness_idが存在すれば投稿できること' do
        expect(@review).to be_valid
      end
    end
    
    context 'レビューを投稿できない場合' do
      it 'imageが空では投稿できないこと' do
        @review.image = nil
        @review.valid?
        expect(@review.errors.full_messages).to include("Image can't be blank")
      end

      it 'nameが空では投稿できないこと' do
        @review.name = nil
        @review.valid?
        expect(@review.errors.full_messages).to include("Name can't be blank")
      end

      it 'priceが空では投稿できないこと' do
        @review.price = nil
        @review.valid?
        expect(@review.errors.full_messages).to include("Price can't be blank")
      end

      it 'contentが空では投稿できないこと' do
        @review.content = nil
        @review.valid?
        expect(@review.errors.full_messages).to include("Content can't be blank")
      end

      it 'manufactureは「--」を選択すると投稿できないこと' do
        @review.manufacture_id = 1
        @review.valid?
        expect(@review.errors.full_messages).to include('Manufacture Select')
      end

      it 'typeは「--」を選択すると投稿できないこと' do
        @review.type_id = 1
        @review.valid?
        expect(@review.errors.full_messages).to include('Type Select')
      end

      it 'hardnessは「--」を選択すると投稿できないこと' do
        @review.hardness_id = 1
        @review.valid?
        expect(@review.errors.full_messages).to include('Hardness Select')
      end

      it 'spinは「--」を選択すると投稿できないこと' do
        @review.spin_id = 1
        @review.valid?
        expect(@review.errors.full_messages).to include('Spin Select')
      end

      it 'speedは「--」を選択すると投稿できないこと' do
        @review.speed_id = 1
        @review.valid?
        expect(@review.errors.full_messages).to include('Speed Select')
      end

      it 'controlは「--」を選択すると投稿できないこと' do
        @review.control_id = 1
        @review.valid?
        expect(@review.errors.full_messages).to include('Control Select')
      end

      it 'evaluationは「--」を選択すると投稿できないこと' do
        @review.evaluation_id = 1
        @review.valid?
        expect(@review.errors.full_messages).to include('Evaluation Select')
      end

      it 'priceは全角数字では投稿できないこと' do
        @review.price = '１００００'
        @review.valid?
        expect(@review.errors.full_messages).to include("Price must be greater than 0")
      end
    end
  end
end
