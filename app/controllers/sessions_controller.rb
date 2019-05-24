class SessionsController < ApplicationController
  self.allow_forgery_protection = false
  layout "admin"
  def new
  end

  def create

    email = params[:session][:email].downcase
    password = params[:session][:password]

    user = User.find_by(email: email)

    if user && user.authenticate(password)
      if user && !user.activated?
        puts "User #{email} is not activated!"
        flash[:warning] = "Account is not activated. Check your email for activation link."
        redirect_to root_url
      else
        puts "User #{email} is now logged in!"
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      end
    else
      puts "User #{email} entered an invalid password"
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
