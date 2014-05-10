require "spec_helper"
require "user"

describe User do
  context "add user to the db" do
    it "should be created with an email and password" do
      user = User.create(:email => "alex@me.com",  :password => "password")
      expect(User.count).to eq 1
      expect(user.email).to eq "alex@me.com"
    end

  end

end