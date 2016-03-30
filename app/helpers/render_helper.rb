module RenderHelper
  def render_not_found
    render json: { errors: { status: ['Not found'] } }, status: :not_found
  end

  def render_bad_request(errors = nil)
    errors ||= { status: ['Bad request'] }
    render json: { errors: errors }, status: :bad_request
  end

  def render_unathorized(errors = nil)
    errors ||= { status: ['Unauthorized'] }
    render json: { errors: errors }, status: :unauthorized
  end

  def render_forbidden(errors = nil)
    errors ||= { status: ['Forbidden'] }
    render json: { errors: errors }, status: :forbidden
  end
end