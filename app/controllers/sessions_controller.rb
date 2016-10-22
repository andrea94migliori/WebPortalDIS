class SessionsController < ApplicationController

  def new
  end

  def create
    employee = Employee.find_by(email: params[:session][:email].downcase)
    if employee && employee.authenticate(params[:session][:password])
      log_in employee
      redirect_to employee
    else
      flash[:danger] = 'email o password errati'
      redirect_to root_url
    end
  end

  def destroy
  end
  
  def destroy
    log_out
    redirect_to root_url
  end
  
end
