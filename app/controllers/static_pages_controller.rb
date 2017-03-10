class StaticPagesController < ApplicationController
  def index
    @course = Course.all
  end

  def privacy
  end

  def team
  end

  def careers
  end 

end
