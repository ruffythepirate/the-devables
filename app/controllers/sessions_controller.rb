class SessionsController < ApplicationController
  layout "admin"
  def new
  end

  def create

    email = params[:session][:email].downcase
    password = params[:session][:password]

    user = Users.find_by(email: email)

    if user && user.authenticate(password)

    else 
      flash[:danger] = 'Invalid email/password combination'
      render 'new'
    end


  end

  def destroy
  end
end
