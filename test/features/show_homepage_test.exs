defmodule ShowHomePageTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session()

  test "the truth" do
    navigate_to("/")
    assert visible_page_text() =~ "niclan"
  end
end
