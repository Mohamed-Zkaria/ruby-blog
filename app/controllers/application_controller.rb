class ApplicationController < ActionController::API

  def not_found
    render :json => {message: 'Not Found'}, :status => '404'
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = Jsonwebtoken.decode(header)
      render json:{ errors:"invalid token" }, status: :unauthorized unless Jsonwebtoken.valid_token?(@decoded[:expiry_time])
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def owns_post?
    begin
      @post = Post.find(params[:id]) 
      render json: {errors: "Unauthorized"}, status: :unauthorized unless @post.user_id == @current_user.id
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    end

  end

end
