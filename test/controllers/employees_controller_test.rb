require 'test_helper'

class EmployeesControllerTest < ActionController::TestCase
    
    
    test "should get new" do
        get :new
        assert_response :success
    end

    test "shouldn't redirect create when not logged in" do
        assert_difference 'Employee.count' do
            post :create, employee: {       nome: "Peter", cognome: "Green" ,sesso: "M" ,dataNascita: '1994-3-24',
                                            nazioneNascita: "Italia", luogoNascita: "Roma", nazioneResidenza: "Italia",
                                            cittaResidenza: "Roma", indirizzo: "via roma 5", tipoAccount: "Dipendente",
                                            email: "employee@example.com", lingua: "it", password: "foobar",
                                            password_confirmation: "foobar" }
        end
        assert_template 'email-sent'
    end


end
