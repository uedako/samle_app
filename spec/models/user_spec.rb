require 'spec_helper'

describe User do
  before { @user = User.new(name: "test user", email: "test@example.com") }

  subject { @user }

  # 属性があるかどうかを確認
  it { should respond_to(:name) }
  it { should respond_to(:email) }

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end
  
  describe "when email format is valid" do
    it "should be valid" do
     address = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
     address.each do |valid_address|
       @user.email = valid_address
       expect(@user).to be_valid
     end
    end
  end

end
