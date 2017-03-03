class StaticPagesController < ApplicationController
  def index
    @course = Course.all
  end

  def privacy
  end
  
end
