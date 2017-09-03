require 'test_helper'

class IndelenControllerTest < ActionDispatch::IntegrationTest
  
  setup do
    @toernooi = toernoois(:one)
    @groep = groeps(:one)
    @toernooi.groeps = [@groep]
  end

  test "should get index" do
    get "/indelen/#{@toernooi.id}"
    assert :success
  end

end
