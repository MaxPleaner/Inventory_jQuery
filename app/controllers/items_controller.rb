class ItemsController < ApplicationController
  before_action :require_current_user
  before_action :find_item, only: %i[show destroy update]
  before_action :find_container, only: %i[create bulk_create]

  def show
    @container = @item.container
    @ancestors = @container.ancestors
  end

  def create
    item = @container.items.create(name: params[:name])
    unless item.valid?
      flash[:error] = item.errors.full_messages.join(", ")
    end
    redirect_to container_url(@container)
  end

  def destroy
    @container = @item.container
    @item.destroy
    redirect_to @container
  end

  def update
    item_params = params.permit(:name)
    unless @item.update(item_params)
      flash[:error] = @item.errors.full_messages.join(", ")
    end
    redirect_to @item
  end

  def bulk_create
    names = params[:text].split("\n")
    names.each do |name|
      @container.items.create(name: name)
    end
    redirect_to @container
  end

  private

  def find_container
    @container = current_user.containers.find_by(id: params[:container_id])
    unless @container
      flash[:error] = "Container not found"
      redirect_to :root
    end
  end

  def find_item
    @item = current_user.items.find_by(id: params[:id])
    unless @item
      flash[:error] = "Item not found"
      redirect_to :root
    end
  end
end
