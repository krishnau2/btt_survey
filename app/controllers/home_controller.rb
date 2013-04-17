class HomeController < ApplicationController

	skip_before_filter :authenticate

  def index
  	@surveys = Survey.published_surveys
  end
end
