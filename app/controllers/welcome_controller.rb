class WelcomeController < ApplicationController
  def index
    flash[:warning] = "hi..mirai"
  end
end
