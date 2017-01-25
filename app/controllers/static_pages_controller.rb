class StaticPagesController < ApplicationController
  def index
    @course = Course.all
  end
end
