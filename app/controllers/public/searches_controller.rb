class Public::SearchesController < ApplicationController
  
  def search
    @range = params[:range]
    search = params[:search]
    word = params[:word]
    
    if @range == '1'
      @contributor = Contributor.search(search,word)
    else
      @post = Post.search(search,word)
    end
  end  
  
end
