class EmployeeMailer < ActionMailer::Base
    default :from => "webportaldiag@gmail.com"

 def registration_confirmation(employee)
    @employee = employee
    mail(:to => "#{employee.nome} <#{employee.email}>", :subject => "Registration Confirmation")
 end
 
 def password_reset(employee)
     @employee = employee
     mail(:to => "#{employee.nome} <#{employee.email}>", :subject => "Password Reset")
 end
 
end
