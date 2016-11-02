require 'test_helper'

class VisitorsControllerTest < ActionController::TestCase
    
    def setup
        @visitor = visitors(:frank)
    end

  
    test "should redirect create when not logged in" do
        assert_no_difference 'Visitor.count' do
            post :create, visitor: {    nome: "Peter", cognome: "Green", sesso: "M", dataNascita: '1994-1-1',
                                    nazioneNascita: "Italia", luogoNascita: "Roma", nazioneResidenza: "Italia",
                                    cittaResidenza: "Roma", indirizzo: "via roma 5", matricola: "1234567",
                                    email: "visitor@example.com", employee_id: 1, password: "foobar",
                                    password_confirmation: "foobar" }
            end
        assert_redirected_to login_url
    end

end
