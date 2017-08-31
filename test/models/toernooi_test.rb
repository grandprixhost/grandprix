require 'test_helper'

class ToernooiTest < ActiveSupport::TestCase
  setup do
    @toernooi = toernoois(:one)    
  end

  test "should be valid" do
    assert @toernooi.valid?
  end

  test "should have naam" do
    @toernooi.naam = "   "
    assert_not @toernooi.valid?
    @toernooi.naam = nil
    assert_not @toernooi.valid?
  end

  test "should have wedstrijdleider" do
    @toernooi.wedstrijdleider = "   "
    assert_not @toernooi.valid?
    @toernooi.wedstrijdleider = nil
    assert_not @toernooi.valid?
  end

  test "should have datum" do
    @toernooi.datum = nil
    assert_not @toernooi.valid?
    @toernooi.datum = "yyyy-mm-dd"
    assert_not @toernooi.valid?
  end

end
