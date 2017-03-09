defmodule ShowHomePageTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session()

  test "the truth" do
    navigate_to("/")
    assert visible_page_text() =~ "niclan"
    assert visible_page_text() =~ "a musician and a software developer highly "
     <> "interested in clean code and behavior driven development"
  end
end
