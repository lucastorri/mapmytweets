require File.expand_path(File.dirname(__FILE__) + "/../test_helper")

#fakeweb
module Net
  class HTTP
    def self.get(base, path)
      case base + path
        when 'twitter.com/status/user_timeline/public_t.json?count=150000'
          open(File.expand_path(File.dirname(__FILE__) + "/../fixtures/public_twitter.json")).read
        when 'twitter.com/status/user_timeline/private_t.json?count=150000'
          open(File.expand_path(File.dirname(__FILE__) + "/../fixtures/private_twitter.json")).read
        else
          open(File.expand_path(File.dirname(__FILE__) + "/../fixtures/notfound_twitter.json")).read
      end
    end
  end
end

class TwitterTest < ActionController::TestCase

  test "should parse public twitter timeline" do
    
    public_twitter = Twitter.new 'public_t'
    assert public_twitter.public?

    public_timeline = public_twitter.timeline
    assert_equal 2, public_timeline.length
    

	geo_tweets = public_twitter.geo_timeline
	assert_equal 1, geo_tweets.length    
  	assert_equal "Going to Jaraguá do Sul for the weekend.", geo_tweets[0][:text]
  	assert_equal [-30.02298247,-51.21920117], geo_tweets[0][:coordinates]

  end
  
  test "should not parse private twitter timeline" do
  
    private_twitter = Twitter.new 'private_t'
    assert !private_twitter.public?
    
    begin
      private_twitter.timeline
      fail
    rescue PrivateTwitterPageException
    end
    
  end

  test "should not parse inexistent twitter timeline" do
  
    private_twitter = Twitter.new 'xpto'
    assert !private_twitter.public?
    
    begin
      private_twitter.timeline
      fail
    rescue InexistentTwitterPageException
    end
  
  end

end