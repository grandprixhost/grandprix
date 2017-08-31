require 'test_helper'

class ToernooiControllerTest < ActionDispatch::IntegrationTest
  
  setup do
    @toernooi = toernoois(:one)
  end

  test "should get index" do
    get toernoois_path
    assert_response :success
  end

  test "should get new" do
    get new_toernooi_path(@toernooi)
    assert_response :success
  end

  test "should get show" do
    get toernooi_url(@toernooi)
    assert_response :success
  end

  test "should create toernooi" do
    assert_difference "Toernooi.count", 1 do 
      post toernoois_path, params: {toernooi: { naam:"eenofanderschaaktoernooi",
                                               wedstrijdleider: "Eenofanderewedstrijdleider Meteenachternaam",
                                               datum: "2020-11-24" }}
    end
    assert_redirected_to "/toernoois/#{Toernooi.last.id}"
  end

end
