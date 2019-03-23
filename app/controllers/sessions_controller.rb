class SessionsController < ApplicationController
  layout "admin"
  def new
  end

  def create

    email = params[:session][:email].downcase
    password = params[:session][:password]

    user = User.find_by(email: email)

    if user && user.authenticate(password)
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end


  end

  def destroy
  end
end
