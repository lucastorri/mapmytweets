class TweetsMapController < ApplicationController

  def map
    begin
      @geo_tweets = Twitter.new(params[:user]).geo_timeline
    rescue PrivateTwitterPageException
      flash[:error] = 'Pagina privada.'
    rescue InexistentTwitterPageException
      flash[:error] = 'Conta inexistente!'
    rescue Exception
      flash[:error] = 'Erro desconhecido.'
    end
  end

end
