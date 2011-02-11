require "rspec"
require "./user"

describe "User authentication behavior" do

  it "should should authenticate user test" do
    user = User.authenticate("test", "test")
    
  end

  it "should NOT authenticate user bob" do
    user = User.authenticate("bob", "bob")
  end

end

describe "User repo behavior" do
  it "should get user with username passed" do
    user = User.get("test")
    user.id == "test"
  end
end