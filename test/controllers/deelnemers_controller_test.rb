require 'test_helper'

class DeelnemersControllerTest < ActionDispatch::IntegrationTest
  
  setup do 
    @deelnemer = deelnemers(:one)
  end

  test "should get index" do
    get deelnemers_path
    assert_response :success
  end

  test "should get new" do
    get new_deelnemer_path 
    assert_response :success
  end  

  test "should show deelnemer" do
    get deelnemer_url(@deelnemer)
    assert_response :success
  end

  test "should register deelnemer" do
    assert_difference "Deelnemer.count" do 
      post deelnemers_path, params: { deelnemer: { voornaam:"Persoonmervoornaam", 
                                                   achternaam:"Persoonmetachternaam", 
                                                   tussenvoegsel:"", 
                                                   geboortedatum:"2005-04-13" } } 
    end
    assert_redirected_to deelnemers_path
  end

  test "should destroy deelnemer" do
    assert_difference "Deelnemer.count", -1 do 
      delete deelnemer_url(@deelnemer)
    end
    assert_redirected_to deelnemers_path
  end

end
