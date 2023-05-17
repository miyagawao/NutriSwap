# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { post.valid? }
  
    let(:contributor) { create(:contributor) }
    let!(:post) { build(:post, contributor_id: contributor.id) }
    
    context 'titleカラム' do
      it '空欄でないこと' do
        post.title = ''
        is_expected.to eq false
      end
    end
    
    context 'contentカラム' do
      it '空欄でないこと' do
        post.content = ''
        is_expected.to eq false
      end
    end
    
    context 'statusカラム' do
      it 'draftまたはpublishedであること' do
        post.status = ''
        is_expected.to eq false
      end
    end
  end
  
  describe 'アソシエーションのテスト' do
    context 'Contributorモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:contributor).macro).to eq :belongs_to
      end
    end
  end
end
