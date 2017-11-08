class Admin::ComplainsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required

  def index
    @complains = Complain.order(is_replied: :asc, created_at: :desc)
  end

end
