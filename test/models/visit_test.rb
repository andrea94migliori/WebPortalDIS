require 'test_helper'

class VisitTest < ActiveSupport::TestCase
    
    def setup
        
        @employee = Employee.create(nome: "Peter", cognome: "Green", sesso: "M", dataNascita: Date.new(1994,3,24), nazioneNascita: "Italia", luogoNascita: "Roma",
                                    nazioneResidenza: "Italia",  cittaResidenza: "Roma", indirizzo: "via roma 5", tipoAccount: "Dipendente", email: "employee@example.com",
                                    lingua: "it", password: "foobar", password_confirmation: "foobar")
                                    
        @visitor = Visitor.create(nome: "Maria", cognome: "Rossi", sesso: "F", dataNascita: Date.new(1995,1,1), nazioneNascita: "Italia", luogoNascita: "Roma",
                                  nazioneResidenza: "Italia",  cittaResidenza: "Roma", indirizzo: "via milano 5", matricola: "1234566", email: "visitor2@example.com",
                                  employee_id: @employee.id, password: "foobar", password_confirmation: "foobar")
                                  
    
        @visit = @employee.visits.build(dal: Date.new(2016,10,31), al: Date.new(2016,11,5), visitor_id: @visitor.id, employee_id: @employee.id, status: "In Corso")
    
    end
    
    
    
    test "should be valid" do
        assert @visit.valid?, "Sicuramente è valida"
    end




                                                        #FIELDS PRESENCE


    test "start date should be present" do
        @visit.dal = nil
        assert_not @visit.valid?
    end

    test "end date should be present" do
        @visit.al = nil
        assert_not @visit.valid?
    end

    test "visitor should be present" do
        @visit.visitor_id = nil
        assert_not @visit.valid?
    end

    test "employee should be present" do
        @visit.employee_id = nil
        assert_not @visit.valid?
    end

    test "status should be present" do
        @visit.status = nil
        assert_not @visit.valid?
    end


                                                        #FIELDS VALIDATIONS


    test "start date should be prior to end one" do
        @visit.dal = Date.new(2016,10,31)
        @visit.al  = Date.new(2016,10,25)
        assert_not @visit.valid?
    end


    test "two visits with the same start, end and visitor cannot exist" do
        first_visit  = Visit.create(dal: Date.new(2016,10,31), al: Date.new(2016,11,5), visitor_id: @visitor.id, employee_id: @employee.id)
        second_visit = Visit.create(dal: Date.new(2016,10,31), al: Date.new(2016,11,5), visitor_id: @visitor.id, employee_id: @employee.id)
        assert_not second_visit.valid?
    end

    test "order should be most recent first" do
        assert_equal Visit.first, visits(:most_recent)
    end

end
