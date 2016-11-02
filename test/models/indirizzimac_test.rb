require 'test_helper'

class IndirizzimacTest < ActiveSupport::TestCase
 def setup
    @employee = Employee.create( nome: "Example2",cognome: "Example2" ,sesso: "M" ,dataNascita: Date.new(2001,2,3), nazioneNascita: "Italia",luogoNascita: "Roma",nazioneResidenza: "Italia",regione: "lazio" ,  regioneResidenza: "lazio",cittaResidenza: "Roma",
              indirizzo: "via roma 5", email: "employee2@example.com",
              password: "foobar", password_confirmation: "foobar")
   
    @vlan=Vlan.create(nome: 'Informatica2',vlanID: 33)
    
    @indirizzimac = @employee.indirizzimacs.build(hostname: "hostname", macAddress: "00-08-7F-4C-7C-1C", dispositivo: "PC" , connessione: "Wi-Fi", vlan_id: @vlan.id)
 end

 test "should be valid" do
    assert @indirizzimac.valid?
  end

  test "employee id should be present" do
    @indirizzimac.employee_id = nil
    assert_not @indirizzimac.valid?
  end
  
   
 test "vlan id should be present" do
    @indirizzimac.vlan_id = nil
    assert_not @indirizzimac.valid?
  end
  
  test "dispositivo should be present" do
    @indirizzimac.dispositivo = nil
    assert_not @indirizzimac.valid?
  end
  
  test "connessione id should be present" do
    @indirizzimac.connessione = nil
    assert_not @indirizzimac.valid?
  end
  
  test "hostname should be present " do
    @indirizzimac.hostname = "   "
    assert_not @indirizzimac.valid?
  end

  test "hostname should be at most 20 characters" do
    @indirizzimac.hostname = "a" * 21
    assert_not @indirizzimac.valid?
  end
  
  test "hostname should not be too short" do
    @indirizzimac.hostname = "a"
    assert_not @indirizzimac.valid?
  end
  
   test "macaddress should be present " do
    @indirizzimac.macAddress = "   "
    assert_not @indirizzimac.valid?
  end

  test "macaddress should be at most 17 characters" do
    @indirizzimac.macAddress = "a" * 18
    assert_not @indirizzimac.valid?
  end
  
  test "macaddress should not be too short" do
    @indirizzimac.macAddress = "a"*16
    assert_not @indirizzimac.valid?
  end

  #test "order should be most ancient first" do
  #  assert_equal Indirizzimac.first, indirizzimacs(:most_recent)
  #end
  
end
