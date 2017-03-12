defmodule ShowHomePageTest do
  use ExUnit.Case
  use Hound.Helpers

  import HoundSupport

  hound_session()

  test "the truth" do
    navigate_to("/")
    assert visible_page_text() =~ "niclan"
    assert visible_page_text() =~ "a musician and a software developer highly "
     <> "interested in clean code and behavior driven development"

    assert visible_link?("https://github.com/nic-lan")
    assert visible_link?("https://www.linkedin.com/in/nicolaslanguille/")
    assert visible_link?("https://www.instagram.com/whatever_nic_lan/")
  end
end
