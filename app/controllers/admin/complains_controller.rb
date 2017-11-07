class Admin::ComplainsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required

  def index
    @complains = Complain.all
  end

end
