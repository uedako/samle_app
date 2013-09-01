require 'spec_helper'

describe "UserPages" do
  
  subject { page }
  
  describe "signup page" do
    before { visit signup_path }
    
    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end
  
  describe "profile page" do
    # ユーザー変数を作成するためのコードに置き換える
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    
    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end
  
  describe "signup" do
    before { visit signup_path }
    let(:submit) { "Create my account" }
    
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }
        
        it { should have_title('Sign up') }
        it { should have_content('エラー') }
      end

    end
    
    describe "with valid infomation" do
      before do
        fill_in "名前",             with: "Example User"
        fill_in "メールアドレス",   with: "user@example.com"
        fill_in "パスワード",       with: "foobar"
        fill_in "パスワードの確認", with: "foobar"
      end
      
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: "user@example.com")}
        
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: "ようこそ") }
      end
     
    end
  end
  
end
