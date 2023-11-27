class ApplicationController < ActionController::API

    def not_found
        render :json => {message: 'Not Found'}, :status => '404'
    end

    def authorize_request
        header = request.headers['Authorization']
        puts "=" * 100
        puts header
        puts "=" * 100
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

end
