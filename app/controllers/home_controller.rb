class HomeController < ApplicationController
  
  def index
    @articles = Article.all
    
    ids = REDIS.zrevrangebyscore "articles/pv", "inf", 0, limit:[0, 3], :with_scores => true
    @ids=[]
    @scores=[]       
    
    ids.each do |id, score|
      @ids << id
      @scores << score.to_i
    end
    
    @ranking_articles = @ids.map{| id |Article.find(id)}
  end

end
