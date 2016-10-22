require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_select "title", "Dipartimento di Ingegneria Informatica Automatica Gestionale Antonio Ruberti-Sapienza Universtià di Roma"
    assert_response :success
  end

  test "should get normeAccessoRete" do
    get :normeAccessoRete
    assert_select "title", "Norme Accesso Rete | Dipartimento di Ingegneria Informatica Automatica Gestionale Antonio Ruberti-Sapienza Universtià di Roma"
    assert_response :success
  end

  test "should get privacyPolicy" do
    get :privacyPolicy
    assert_select "title", "privacy Policy | Dipartimento di Ingegneria Informatica Automatica Gestionale Antonio Ruberti-Sapienza Universtià di Roma"
    assert_response :success
  end

end
