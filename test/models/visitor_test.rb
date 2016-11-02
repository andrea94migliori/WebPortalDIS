require 'test_helper'

class VisitorTest < ActiveSupport::TestCase
    def setup
        @visitor = Visitor.new(nome: "Peter", cognome: "Green", sesso: "M", dataNascita: Date.new(1994,1,1),
                                 nazioneNascita: "Italia", luogoNascita: "Roma", nazioneResidenza: "Italia",  cittaResidenza: "Roma",
                               indirizzo: "via roma 5", matricola: "1264567", email: "visitor10@example.com", employee_id: 1,
                                 password: "foobar", password_confirmation: "foobar")
    end
    
    
    test "should be valid" do
        assert @visitor.valid?
    end


                                                                        # FIELDS PRESENCE #


    test "nome should be present" do
        @visitor.nome = "     "
        assert_not @visitor.valid?
    end

    test "cognome should be present" do
        @visitor.cognome = "     "
        assert_not @visitor.valid?
    end

    test "sesso should be present" do
        @visitor.sesso = "     "
        assert_not @visitor.valid?
    end

    test "dataNascita should be present" do
        @visitor.dataNascita = "     "
        assert_not @visitor.valid?
    end

    test "nazioneNascita should be present" do
        @visitor.nazioneNascita = "     "
        assert_not @visitor.valid?
    end

    test "luogoNascita should be present" do
        @visitor.luogoNascita = "     "
        assert_not @visitor.valid?
    end

    test "nazioneResidenza should be present" do
        @visitor.nazioneResidenza = "     "
        assert_not @visitor.valid?
    end

    test "cittaResidenza should be present" do
        @visitor.cittaResidenza = "     "
        assert_not @visitor.valid?
    end

    test "indirizzo should be present" do
        @visitor.indirizzo = "     "
        assert_not @visitor.valid?
    end

    test "matricola should be present" do
        @visitor.matricola = "     "
        assert_not @visitor.valid?
    end

    test "email should be present" do
        @visitor.email = "     "
        assert_not @visitor.valid?
    end

    test "employee_id should be present" do
        @visitor.employee_id = "     "
        assert_not @visitor.valid?
    end

                                                                        # CHECK LENGTH VALIDATIONS #


    #TOO SHORT
    test "nome should not be too short" do
        @visitor.nome = "a"
        assert_not @visitor.valid?
    end

    test "cognome should not be too short" do
        @visitor.cognome = "b"
        assert_not @visitor.valid?
    end

    test "indirizzo should not be too short" do
        @visitor.indirizzo = "c" * 6
        assert_not @visitor.valid?
    end

    test "matricola should not be too short" do
        @visitor.matricola = "c" * 6
        assert_not @visitor.valid?
    end

    test "password should not be too short" do
        @visitor.password = "d" * 6
        assert_not @visitor.valid?
    end



    #TOO LONG
    test "nome should not be too long" do
        @visitor.nome = "d" * 21
        assert_not @visitor.valid?
    end

    test "cognome should not be too long" do
        @visitor.cognome = "e" * 21
        assert_not @visitor.valid?
    end

    test "luogoNascita should not be too long" do
        @visitor.luogoNascita = "f" * 61
        assert_not @visitor.valid?
    end

    test "cittaResidenza should not be too long" do
        @visitor.cittaResidenza = "g" * 61
        assert_not @visitor.valid?
    end

    test "indirizzo should not be too long" do
        @visitor.indirizzo = "h" * 61
        assert_not @visitor.valid?
    end

    test "matricola should not be too long" do
        @visitor.matricola = "h" * 8
        assert_not @visitor.valid?
    end

    test "email should not be too long" do
        @visitor.email = "i" * 244 + "@example.com"
        assert_not @visitor.valid?
    end

                                                                            # EMAIL VALIDATION #

    test "email validation should accept valid addresses" do
        valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
        valid_addresses.each do |valid_address|
            @visitor.email = valid_address
            assert @visitor.valid?, "#{valid_address.inspect} should be valid"
        end
        
        valid_addresses = %w[userATexample.com user-foo.com]
        valid_addresses.each do |valid_address|
            @visitor.email = valid_address
            assert_not @visitor.valid?, "#{valid_address.inspect} should not be valid"
        end
    end

    test "email addresses should be unique" do
        same_visitor = @visitor.dup
        same_visitor.email = @visitor.email.upcase
        @visitor.save
        assert_not same_visitor.valid?
    end

    test "email addresses should be saved as lower-case" do
        mixed_case_email = "visitor@ExAMPle.CoM"
        @visitor.email = mixed_case_email
        @visitor.save
        assert_equal mixed_case_email.downcase, @visitor.reload.email
    end



                                                                                # PASSWORD #

    test "password should have a minimum length" do
        @visitor.password = @visitor.password_confirmation = "a" * 5
        assert_not @visitor.valid?
    end

    test "password should be equal to password_confirmation" do
        @visitor.password_confirmation = "a" * 10
        assert_not @visitor.valid?, "Password and password_confirmation should be equal"
    end


                                                                                #DEPENDENT :DESTROY
    test "associated visits should be destroyed" do
        @visitor.save
        @visitor.visits.create!(dal: Date.new(2016,10,31), al: Date.new(2016,11,5), visitor_id: @visitor.id, employee_id: 1, status: "In Corso")
        assert_difference 'Visit.count', -1 do
            @visitor.destroy
        end
    end

end
