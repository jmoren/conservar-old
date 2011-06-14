class AdminController < ApplicationController
  before_filter :login_required_and_admin

  def index

  end
end

