module NameDescriptionController
  def index
    @objects = model.all
    render 'name_description/index'
  end

  def show
    id = params[:id]
    if model.exists? id
      @object = model.find id
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
    id = params[:id]
    if model.exists? id
      object = model.find id
      object.from_api params

      if object.save
        render plain: 'OK'
      else
        render json: object.errors
      end
    else
      render plain: 'Not found'
    end
  end

  def destroy
    id = params[:id]
    if model.exists? id
      model.find(id).destroy
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