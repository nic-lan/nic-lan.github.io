defmodule HoundSupport do
  use Hound.Helpers

  def visible_link?(link) do
    find_all_elements(:tag, "a")
    |> Enum.any?(fn element -> attribute_value(element, "href") == link end)
  end
end
