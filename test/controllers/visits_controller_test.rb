require 'test_helper'

class VisitsControllerTest < ActionController::TestCase

    test "should redirect create when not logged in" do
        assert_no_difference 'Visit.count' do
            post :create, visit: {  dal: '2016-9-1', al: '2016-10-1', visitor_id: 3, employee_id: 2,
                                    status: "In Corso" }
        end
        assert_redirected_to login_url
    end

end
