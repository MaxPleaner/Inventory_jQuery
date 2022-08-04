class ContainersController < ApplicationController
  before_action :require_current_user
  before_action :find_container, only: %i[show]

  def show
    @items = @container.items
  end

  def find_container
    @container = current_user.containers.find_by(id: params[:id])
    unless @container
      flash[:error] = "Container not found"
      redirect_to :root
    end
  end
end
