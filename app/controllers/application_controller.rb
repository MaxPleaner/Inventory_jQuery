class ApplicationController < ActionController::Base

  # ========================
  # Utility Methods
  # ========================

  def require_current_user
    unless current_user
      redirect_to :root
    end
  end

  helper_method :current_user
  def current_user
    return unless session[:user_id]
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # ========================
  # Endpoints
  # ========================

  before_action :require_current_user,  only: %i[move_object search]

  def index
    if current_user
      redirect_to container_url(current_user.root_container)
    else
      render "landing"
    end
  end

  def search_items
    @query = params[:query]
    if @query.blank?
      @items = []
    else
      @items = current_user.items.where("items.name LIKE ?", "%#{@query}%")
    end
    binding.pry
    render :search
  end

  def move_object
    container = current_user.containers.find(params[:container_id])

    types = {
      "container" => current_user.containers,
      "item" => current_user.items
    }

    draggable_type = types.fetch(params[:draggable_type])
    droppable_type = types.fetch(params[:droppable_type])

    draggable = draggable_type.find(params[:draggable_id])
    # note: the UI only lets you drop to containers, so this is pointless:
    droppable = droppable_type.find(params[:droppable_id])

    if draggable.is_a?(Item)
      draggable.update(container: droppable)
    else
      draggable.update(parent: droppable)
    end

    redirect_to container
  end

  def login
    token = flash[:google_sign_in]["id_token"]
    email = GoogleSignIn::Identity.new(token).email_address
    session[:user_id] = User.find_or_create_by(email: email).id
    redirect_to "/"
  end

  def logout
    session.delete(:user_id)
    redirect_to "/"
  end
end
