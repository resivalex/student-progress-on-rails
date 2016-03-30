module NameDescriptionController
  extend ActiveSupport::Concern

  included do
    before_filter :require_admin, only: [:create, :update, :destroy]
  end

  def index
    @objects = model.all
    render 'name_description/index'
  end

  def show
    @object = model.find_by_id params[:id]
    if @object
      render 'name_description/show'
    else
      render_not_found
    end
  end

  def create
    object = model.new.from_api params

    if object.save
      render nothing: true
    else
      render_bad_request object.errors
    end
  end

  def update
    object = model.find_by_id params[:id]
    if object
      object.from_api params

      if object.save
        render nothing: true
      else
        render_bad_request object.errors
      end
    else
      render_not_found
    end
  end

  def destroy
    object = model.find_by_id params[:id]
    if object
      object.destroy
      render nothing: true
    else
      render_not_found
    end
  end

  private

  def model
    controller_name.classify.constantize
  end
end