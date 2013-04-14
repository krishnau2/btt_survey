class HomeController < ApplicationController
  def index
  	@surveys = Survey.published_surveys
  end
end
