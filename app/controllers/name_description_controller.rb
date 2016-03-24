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
      render plain: 'Not found'
    end
  end

  def create
    object = model.new.from_api params

    if object.save
      render plain: 'OK'
    else
      render json: object.errors, status: :bad_request
    end
  end

  def update
    object = model.find_by_id params[:id]
    if object
      object.from_api params

      if object.save
        render plain: 'OK'
      else
        render json: object.errors, status: :bad_request
      end
    else
      render plain: 'Not found', status: :not_found
    end
  end

  def destroy
    object = model.find_by_id params[:id]
    if object
      object.destroy
      render plain: 'OK'
    else
      render plain: 'Not found', status: :not_found
    end
  end

  private

  def model
    controller_name.classify.constantize
  end
end