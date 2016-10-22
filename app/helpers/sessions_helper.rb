module SessionsHelper
  
  # Logs in the given user.
  def log_in(employee)
    session[:employee_id] = employee.id
  end
  
  def log_out
    session.delete(:employee_id)
    @current_employee = nil
  end
  
  # Returns the current logged-in user (if any).
  def current_employee
    @current_employee ||= Employee.find_by(id: session[:employee_id])
  end
  
  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_employee.nil?
  end
  
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
  
end
