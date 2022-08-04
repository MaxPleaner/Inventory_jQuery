class ContainersController < ApplicationController
  before_action :require_current_user
  before_action :find_container, only: %i[show create]

  def show
    @items = @container.items
    @subcontainers = @container.children
    @parent = @container.parent
  end

  def create
    @subcontainer = @container.children.create(
      name: params[:name],
      user: @container.user
    )
    if !@subcontainer.valid?
      flash[:error] = @subcontainer.errors.full_messages.join(", ")
    end
    redirect_to @container
  end

  def find_container
    @container = current_user.containers.find_by(id: params[:id])
    unless @container
      flash[:error] = "Container not found"
      redirect_to :root
    end
  end
end
