
class SessionsController < ApplicationController

    # login a user
    def create
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: { errors: ["Invalid username or password"] }, status: :unauthorized
        end
    end

    # logout the user
    def destroy
        user = User.find_by(id: session[:user_id])
        if user 
          session.delete(:user_id)
         else
            render json: { errors: ["not user"] }, status: 401
         end
    end

end