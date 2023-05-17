# frozen_string_literal: true

require 'rails_helper'

describe '投稿のテスト' do
  let!(:genre) { create(:genre) }
  let!(:post) { create(:post, title: 'hoge', content: 'content', genre: genre) }
  describe 'トップ画面(root_path)のテスト' do
    before do
      visit root_path
    end
    context '表示の確認' do
      it 'トップ画面(root_path)に投稿一覧が表示されているか' do
        expect(page).to have_content '投稿一覧'
      end
      it 'root_pathが"/"であるか' do
        expect(current_path).to eq('/')
      end
    end
  end
  
  describe "投稿画面(new_post_path)のテスト" do
    before do
      contributor = create(:contributor) # ファクトリーボットでユーザーアカウントを作成
      visit new_contributor_session_path
      fill_in 'contributor[email]', with: contributor.email
      fill_in 'contributor[password]', with: contributor.password
      click_button 'ログイン'
      visit new_post_path
    end
    context '表示の確認' do
      it 'new_post_pathが"/posts/new"であるか' do
        expect(current_path).to eq('/posts/new')
      end
      it '投稿ボタンが表示されているか' do
        expect(page).to have_button '投稿'
      end
    end
    context '投稿処理のテスト' do
      it '投稿後のリダイレクト先は正しいか' do
        genre = create(:genre, name: 'Test Genre')
        visit new_post_path
        fill_in 'post[title]', with: 'hoge'
        fill_in 'post[content]', with: 'content'
        # ジャンルを選択する
        select genre.name, from: 'post[genre_id]'
        click_button '投稿する'
        # リダイレクト先のパスを正しく指定する
        expect(page).to have_current_path post_path(Post.last)
      end
    end
  end
  
  describe "投稿一覧のテスト" do
    before do
      genre = create(:genre)
      create(:post, title: 'hoge', content: 'content', genre: genre)
      visit posts_path
    end
    context '表示の確認' do
      it '投稿されたものが表示されているか' do
        expect(page).to have_content post.title
        expect(page).to have_link post.title
        expect(page).to have_content genre.name
        expect(page).to have_link genre.name, href: posts_path(genre_id: genre.id, genre_name: genre.name)
      end
    end
  end
  
end