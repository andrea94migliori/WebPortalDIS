require 'test_helper'

class IndirizzimacsControllerTest < ActionController::TestCase
  def setup
    @indirizzimac = indirizzimacs(:orange)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Indirizzimac.count' do
      post :create, indirizzimac: { hostname: "FirstOne", macAddress: "00-08-74-4C-7F-1D", dispositivo: "PC" , connessione: "Wi-Fi",vlan: "Informatica"}
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Indirizzimac.count' do
      delete :destroy, id: @indirizzimac
    end
    assert_redirected_to login_url
  end
end
