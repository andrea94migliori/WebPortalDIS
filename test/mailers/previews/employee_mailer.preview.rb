class EmployeeMailerPreview < ActionMailer::Preview
    
    def account_activation
        employee = Employee.first
        employee.confirm_token = Employee.new_token
        EmployeeMailer.registration_confirmation(employee)
    end

    
    # Preview this email at
    # http://localhost:3000/rails/mailers/user_mailer/password_reset
    def password_reset
        employee = Employee.first
        employee.reset_token = Employee.new_token
        EmployeeMailer.password_reset(employee)
    end
end
