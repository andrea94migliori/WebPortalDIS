require 'test_helper'
require 'date'

class EmployeeTest < ActiveSupport::TestCase
  
  def setup
      @employee = Employee.new(nome: "Peter", cognome: "Green" ,sesso: "M" ,dataNascita: Date.new(1994,3,24),
                               nazioneNascita: "Italia", luogoNascita: "Roma", nazioneResidenza: "Italia",  cittaResidenza: "Roma",
                               indirizzo: "via roma 5", tipoAccount: "Dipendente", email: "employee@example.com", lingua: "it",
                               password: "foobar", password_confirmation: "foobar")
  end


    test "should be valid" do
        assert @employee.valid?
    end
  

                                            # FIELDS PRESENCE #

  
    test "nome should be present" do
        @employee.nome = "     "
        assert_not @employee.valid?
    end

    test "cognome should be present" do
        @employee.cognome = "     "
        assert_not @employee.valid?
    end
  
    test "sesso should be present" do
        @employee.sesso = "     "
        assert_not @employee.valid?
    end
  
    test "dataNascita should be present" do
        @employee.dataNascita = "     "
        assert_not @employee.valid?
    end
  
    test "nazioneNascita should be present" do
        @employee.nazioneNascita = "     "
        assert_not @employee.valid?
    end
  
    test "luogoNascita should be present" do
        @employee.luogoNascita = "     "
        assert_not @employee.valid?
    end
  
    test "nazioneResidenza should be present" do
        @employee.nazioneResidenza = "     "
        assert_not @employee.valid?
    end
  
    test "cittaResidenza should be present" do
        @employee.cittaResidenza = "     "
        assert_not @employee.valid?
    end
  
    test "indirizzo should be present" do
        @employee.indirizzo = "     "
        assert_not @employee.valid?
    end
  
    test "email should be present" do
        @employee.email = "     "
        assert_not @employee.valid?
    end
  
                                            # CHECK LENGTH VALIDATIONS #


                #TOO SHORT
    test "nome should not be too short" do
        @employee.nome = "a"
        assert_not @employee.valid?
    end
  
    test "cognome should not be too short" do
        @employee.cognome = "b"
        assert_not @employee.valid?
    end
  
    test "indirizzo should not be too short" do
        @employee.indirizzo = "c" * 6
        assert_not @employee.valid?
    end

    test "password should not be too short" do
        @employee.password = "d" * 6
        assert_not @employee.valid?
    end

  

                #TOO LONG
    test "nome should not be too long" do
        @employee.nome = "d" * 21
        assert_not @employee.valid?
    end
  
    test "cognome should not be too long" do
        @employee.cognome = "e" * 21
        assert_not @employee.valid?
    end
  
    test "luogoNascita should not be too long" do
        @employee.luogoNascita = "f" * 61
        assert_not @employee.valid?
  end
  
    test "cittaResidenza should not be too long" do
        @employee.cittaResidenza = "g" * 61
        assert_not @employee.valid?
    end
  
    test "indirizzo should not be too long" do
        @employee.indirizzo = "h" * 61
        assert_not @employee.valid?
    end
  
    test "email should not be too long" do
        @employee.email = "i" * 244 + "@example.com"
        assert_not @employee.valid?
    end
  
                                            # EMAIL VALIDATION #

    test "email validation should accept valid addresses" do
        valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
        valid_addresses.each do |valid_address|
            @employee.email = valid_address
            assert @employee.valid?, "#{valid_address.inspect} should be valid"
        end
        
        valid_addresses = %w[userATexample.com user-foo.com]
        valid_addresses.each do |valid_address|
            @employee.email = valid_address
            assert_not @employee.valid?, "#{valid_address.inspect} should not be valid"
        end
    end
  
    test "email addresses should be unique" do
        same_employee = @employee.dup
        same_employee.email = @employee.email.upcase
        @employee.save
        assert_not same_employee.valid?
    end

    test "email addresses should be saved as lower-case" do
        mixed_case_email = "EmployeE@ExAMPle.CoM"
        @employee.email = mixed_case_email
        @employee.save
        assert_equal mixed_case_email.downcase, @employee.reload.email
    end


  
                                            # PASSWORD #
  
    test "password should have a minimum length" do
        @employee.password = @employee.password_confirmation = "a" * 5
        assert_not @employee.valid?
    end
    
    test "password should be equal to password_confirmation" do
        @employee.password_confirmation = "a" * 10
        assert_not @employee.valid?, "Password and password_confirmation should be equal"
    end




                                        #DEPENDENT :DESTROY
    test "associated visits should be destroyed" do
        @employee.save
        @employee.visits.create!(dal: Date.new(2016,10,31), al: Date.new(2016,11,5), visitor_id: 1, employee_id: @employee.id, status: "In Corso")
        assert_difference 'Visit.count', -1 do
            @employee.destroy
        end
    end

    test "associated visitors should be destroyed" do
        @employee.save
        @employee.visitors.create!(nome: "Peter", cognome: "Green", sesso: "M", dataNascita: Date.new(1994,1,1),
                                   nazioneNascita: "Italia", luogoNascita: "Roma", nazioneResidenza: "Italia",  cittaResidenza: "Roma",
                                   indirizzo: "via roma 5", matricola: "1234560", email: "visitor5@example.com", employee_id: @employee.id,
                                   password: "foobar", password_confirmation: "foobar")
        assert_difference 'Visitor.count', -1 do
            @employee.destroy
        end
    end

    test "associated macaddresses should be destroyed" do
        @employee.save
        @employee.indirizzimacs.create!(hostname: "hostname", macAddress: "00-08-7F-4C-7C-1C", dispositivo: "PC" , connessione: "Wi-Fi", vlan_id: 1)
        assert_difference 'Indirizzimac.count', -1 do
            @employee.destroy
        end
    end

end
