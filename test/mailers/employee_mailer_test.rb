require 'test_helper'

class EmployeeMailerTest < ActionMailer::TestCase
    
    test "account_activation" do
        employee = employees(:andrew)
        employee.confirm_token = Employee.new_token
        mail = EmployeeMailer.registration_confirmation(employee)
        assert_equal "Registration Confirmation", mail.subject
        assert_equal [employee.email], mail.to
        assert_equal ["webportaldiag@gmail.com"], mail.from
        assert_match employee.nome,               mail.body.encoded
        assert_match employee.confirm_token,   mail.body.encoded
    end

    test "password_reset" do
        employee = employees(:andrew)
        employee.reset_token = Employee.new_token
        mail = EmployeeMailer.password_reset(employee)
        assert_equal "Password Reset", mail.subject
        assert_equal [employee.email], mail.to
        assert_equal ["webportaldiag@gmail.com"], mail.from
        assert_match employee.reset_token,        mail.body.encoded
        assert_match CGI.escape(employee.email),  mail.body.encoded
    end

end
