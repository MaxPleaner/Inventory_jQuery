class ItemsController < ApplicationController
  before_action :require_current_user
  before_action :find_item, only: %i[show destroy update add_tag remove_tag]
  before_action :find_container, only: %i[create bulk_create]

  def show
    @container = @item.container
    @ancestors = @container.ancestors
    @tags = @item.tags
    @all_tag_names = current_user.tags.pluck(:name)
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

  def search
    @query = params[:query]
    @tag = params[:tag]
    if @tag == "all" && @query.blank?
      @items = []
    elsif @tag == "all" && @query.present?
      @items = current_user.items.where("items.name LIKE ?", "%#{@query}%")
    else
      @items = current_user.items.joins(:tags).where(tags: { name: @tag })
      @items = @items.where("items.name LIKE ?", "%#{@query}%")
    end

    @all_tag_names = ["all"] + current_user.tags.pluck(:name)
  end


  def add_tag
    tag = current_user.tags.find_or_create_by(name: params[:name])
    tagging = ItemTagging.find_or_create_by(item: @item, tag: tag)

    redirect_to @item
  end

  def remove_tag
    tag = current_user.tags.find_by!(name: params[:name])
    tagging = ItemTagging.find_by!(item: @item, tag: tag)
    tagging.destroy!
    if tag.item_taggings.empty?
      tag.destroy!
    end
    redirect_to @item
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
