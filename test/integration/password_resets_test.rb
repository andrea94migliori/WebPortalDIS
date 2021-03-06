require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
    
    def setup
        ActionMailer::Base.deliveries.clear
        @employee = employees(:andrew)
    end


    test "password resets" do
        get new_password_reset_path
        assert_template 'password_resets/new'

        # Invalid email
        post password_resets_path, password_reset: { email: "" }
        assert_not flash.empty?
        assert_template 'password_resets/new'

        # Valid email
        post password_resets_path, password_reset: { email: @employee.email }
        assert_not_equal @employee.reset_digest, @employee.reload.reset_digest
        assert_equal 1, ActionMailer::Base.deliveries.size
        assert_not flash.empty?
        assert_template 'password_resets/reset-sent'

        # Password reset form
        employee = assigns(:employee)
       
        # Wrong email
        get edit_password_reset_path(employee.reset_token, email: "")
        assert_redirected_to root_url
        
        # Inactive employee
        employee.toggle!(:email_confirmed)
        get edit_password_reset_path(employee.reset_token, email: employee.email)
        assert_redirected_to root_url
        employee.toggle!(:email_confirmed)
        
        # Right email, wrong token
        get edit_password_reset_path('wrong token', email: employee.email)
        assert_redirected_to root_url
       
        # Right email, right token
        get edit_password_reset_path(employee.reset_token, email: employee.email)
        assert_template 'password_resets/edit'
        assert_select "input[name=email][type=hidden][value=?]", employee.email
        
        # Invalid password & confirmation
        patch password_reset_path(employee.reset_token),
        email: employee.email, employee: { password: "foobaz", password_confirmation: "barquux" }
        assert_select 'div#error_explanation'

        # Empty password
        patch password_reset_path(employee.reset_token),
        email: employee.email, employee: { password: "", password_confirmation: "" }
        assert_select 'div#error_explanation'

        # Valid password & confirmation
        patch password_reset_path(employee.reset_token),
        email: employee.email, employee: { password: "foobaz", password_confirmation: "foobaz" }
        assert_not flash.empty?
        #assert_redirected_to employee
        assert_template :edit

    end

end
