require 'test_helper'

class InschrijvenControllerTest < ActionDispatch::IntegrationTest
  
  setup do
    @toernooi = toernoois(:one)
    @toernooi.groeps = [groeps(:one), groeps(:two)]
    @deelnemer = deelnemers(:one)
  end

  test "should get new" do
    get "/inschrijven/#{@toernooi.id}"
    assert :success
  end
end
