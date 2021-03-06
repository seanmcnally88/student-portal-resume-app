class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:email]
    password = params[:password]

    student = Unirest.get("http://172.28.113.208:3000/studentssignin.json",
      headers:{ "Accept" => "application/json"},
      parameters: {email: email, password: password}
      ).body

    if student["id"]
      session[:email] = email
      session[:password] = password
      redirect_to "/profiles/#{student["id"]}"
      flash[:success] = "You have successfully signed in!"
    else
      flash[:danger] = "Incorrect username/password combination"
      render 'new'
    end
    
  end

  def destroy
    session[:email] = nil
    session[:password] = nil
    redirect_to '/sign_in'
    flash[:success] = "You have successfully signed out!"
  end
end
