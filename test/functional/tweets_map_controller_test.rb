require File.expand_path(File.dirname(__FILE__) + "/../test_helper")

class TweetsMapControllerTest < ActionController::TestCase

  test "should return tweets with geolocation from a user with public timeline" do
    get :map, :user => 'public_t'
    assert_response :success
    assert_not_nil assigns(:geo_tweets)
	
	assert_template ''
  end
end
