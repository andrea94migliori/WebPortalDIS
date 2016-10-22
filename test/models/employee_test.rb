require 'test_helper'
require 'date'

class EmployeeTest < ActiveSupport::TestCase
  
  def setup
    @employee = Employee.new( nome: "Example",cognome: "Example1" ,sesso: "M" ,dataNascita: Date.new(2001,2,3),
              nazioneNascita: "Italia",luogoNascita: "Roma",nazioneResidenza: "Italia", cittaResidenza: "Roma",
              indirizzo: "via roma 5",tipoAccount: "studente del DIS",matricola: "1235567",email: "employee@example.com",
              password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @employee.valid?
  end
  
  ################################################# PRESENCE ##################################################################
  
  
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
  
  test "tipoAccount should be present" do
    @employee.tipoAccount = "     "
    assert_not @employee.valid?
  end
  
  test "matricola should be present" do
    @employee.matricola = "     "
    assert_not @employee.valid?
  end
  
  test "email should be present" do
    @employee.email = "     "
    assert_not @employee.valid?
  end
  
  ################################################# TOO SHORT ##################################################################
  
  test "nome should not be too short" do
    @employee.nome = "a"
    assert_not @employee.valid?
  end
  
  test "cognome should not be too short" do
    @employee.cognome = "a"
    assert_not @employee.valid?
  end
  
   test "indirizzo should not be too short" do
    @employee.indirizzo = "a" * 6
    assert_not @employee.valid?
  end
  
   test "matricola should not be too short" do
    @employee.matricola = "a" * 6
    assert_not @employee.valid?
  end
  
  ################################################# TOO LONG ##################################################################
  
  test "nome should not be too long" do
    @employee.nome = "a" * 21
    assert_not @employee.valid?
  end
  
  test "cognome should not be too long" do
    @employee.cognome = "a" * 21
    assert_not @employee.valid?
  end
  
  test "luogoNascita should not be too long" do
    @employee.luogoNascita = "a" * 61
    assert_not @employee.valid?
  end
  
   test "cittaResidenza should not be too long" do
    @employee.cittaResidenza = "a" * 61
    assert_not @employee.valid?
  end
  
   test "indirizzo should not be too long" do
    @employee.indirizzo = "a" * 61
    assert_not @employee.valid?
  end
  
   test "matricola should not be too long" do
    @employee.matricola = "a" * 8
    assert_not @employee.valid?
  end
  
  test "email should not be too long" do
    @employee.email = "a" * 244 + "@example.com"
    assert_not @employee.valid?
  end
  
 ################################################# EMAIL VALIDATION ##################################################################
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @employee.email = valid_address
      assert @employee.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "email addresses should be unique" do
    duplicate_employee = @employee.dup
    duplicate_employee.email = @employee.email.upcase
    @employee.save
    assert_not duplicate_employee.valid?
  end
  
  test "matricola should be unique" do
    duplicate_employee = @employee.dup
    @employee.save
    assert_not duplicate_employee.valid?
  end
  
  #######################################################PASSWORD##################################################################
  
  test "password should have a minimum length" do
    @employee.password = @employee.password_confirmation = "a" * 5
    assert_not @employee.valid?
  end
  
 
end
