require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user = build(:user)
  end

  after(:all) do
    User.delete_all
  end

  it "is valid" do
    expect(@user).to be_valid
  end

  it "validates username" do
    @user.username = "  "
    expect(@user).to_not be_valid
  end

  it "validates email" do
    @user.username = "chuks"
    @user.email = "  "
    expect(@user).to_not be_valid
  end

  it "validates email format" do
    @user.email = "improperemail@com"
    expect(@user).to_not be_valid
  end

  it "validates password" do
    @user.email = "chuks@email.com"
    @user.password = " "
    expect(@user).to_not be_valid
  end

  it "ensures password is minimum of 6 chars" do
    @user.password = "pass"
    expect(@user).to_not be_valid
  end

  it "ensures username is maximum of 15 chars" do
    @user.username = "averylongusername"
    expect(@user).to_not be_valid
  end

  it "saves a user" do
    @user.username = "chuks"
    @user.password = "password"
    @user.save!
    expect(User.first.username).to eq 'chuks'
  end

  it "ensures username and email are unique" do
    create(:user)
    expect(@user.save).to eq false
  end  
end
