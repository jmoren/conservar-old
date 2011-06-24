class AdminController < ApplicationController
  before_filter :login_required_and_admin

  def index

  end
  def statistics

  end

  def configuration
    @categories = DetCategory.all
    @institution = Institution.first
  end


end

