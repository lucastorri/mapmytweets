require 'net/http'

class PrivateTwitterPageException < Exception
end

class InexistentTwitterPageException < Exception
end


class Twitter

  @@base_url = 'twitter.com'

  attr_accessor :username

  def initialize(username)
    @username = username
  end
  
  def public?
    pub? get_page
  end
  
  def timeline
    page = get_page
    if not pub? page
      case page['error']
        when 'Not found'
          raise InexistentTwitterPageException
        when 'Not authorized'
          raise PrivateTwitterPageException
        else
          raise Exception
      end
    end
    
    page.collect { |tweet| { :text => tweet['text'], :coordinates => (tweet['geo'] ? tweet['geo']['coordinates'] : nil) } }
  end
  
  def geo_timeline
    timeline.find_all {|tweet| not tweet[:coordinates].nil? }
  end
  
  private
  
  def pub?(page)
  	!(page.is_a? Hash and page['error'])
  end
  
  def get_page
  	JSON.parse(Net::HTTP.get(@@base_url, "/status/user_timeline/#{@username}.json?count=150000"))
  end

end