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

  test "should register unknown deelnemer" do
     assert_difference "Deelnemer.count" do
       post inschrijven_path, params: { toernooi_id: @toernooi.id,
                                        deelnemer: { voornaam:"Persoonmervoornaam", 
                                                     achternaam:"Persoonmetachternaam", 
                                                     tussenvoegsel:"", 
                                                     geboortedatum:"2005-04-13" } }
     end
  end
  
  test "shouldnt register known deelnemer" do
     assert_no_difference "Deelnemer.count" do 
       post inschrijven_path, params: { toernooi_id: @toernooi.id, 
                                        deelnemer: { voornaam: @deelnemer.voornaam,
                                                     achternaam: @deelnemer.achternaam,
                                                     tussenvoegsel:@deelnemer.tussenvoegsel,
                                                     geboortedatum:@deelnemer.geboortedatum } }
     end
  end

end
