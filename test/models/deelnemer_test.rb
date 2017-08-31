require 'test_helper'

class DeelnemerTest < ActiveSupport::TestCase
  def setup 
    @deelnemer = deelnemers(:one)
  end

  test "should be valid" do 
    assert @deelnemer.valid?
  end

  test "should have voornaam" do
    @deelnemer.voornaam = "  "
    assert_not @deelnemer.valid?
    @deelnemer.voornaam = nil
    assert_not @deelnemer.valid?
  end

  test "should have achternaam" do
    @deelnemer.achternaam = "  "
    assert_not @deelnemer.valid?
    @deelnemer.achternaam = nil
    assert_not @deelnemer.valid?
  end

  test "should have geboortedatum" do
    @deelnemer.geboortedatum = "  "
    assert_not @deelnemer.valid?
    @deelnemer.geboortedatum = nil
    assert_not @deelnemer.valid?
  end

end
