class AuthenticationController < ApplicationController
    def login
        @user = User.find_by_email(params[:email])
        if @user&.authenticate(params[:password])
          encoded = Jsonwebtoken.encode(user_id: @user.id)
          token = encoded[:token]
          expiry_time = encoded[:expiry_time]
          render json: { token: token, expiry_time: expiry_time }, status: :ok
        else
          render json: { errors: 'unauthorized' }, status: :unauthorized
        end
    end
    
      private
    
      def login_params
        params.permit(:email, :password)
      end
end