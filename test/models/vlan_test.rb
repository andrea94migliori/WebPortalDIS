require 'test_helper'

class VlanTest < ActiveSupport::TestCase
  require 'test_helper'

  def setup
    @vlan = Vlan.new(nome: 'Informatica',vlanID: 32)
  end

  test "should be valid" do
    assert @vlan.valid?
  end

  test "vlan id should be present" do
    @vlan.vlanID= nil
    assert_not @vlan.valid?
  end
  
  test "vlan name should be present" do
    @vlan.nome = nil
    assert_not @vlan.valid?
  end
  
   test "vlan id should be unique" do
    duplicate_vlan = @vlan.dup
    @vlan.save
    assert_not duplicate_vlan.valid?
  end
  
  
end
