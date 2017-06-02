defmodule ESpec.Phoenix.Extend do
  def model do
    quote do
      alias NicLan.Repo
    end
  end

  def controller do
    quote do
      alias NicLan
      import NicLan.Router.Helpers

      @endpoint NicLan.Endpoint
    end
  end

  def view do
    quote do
      import NicLan.Router.Helpers
    end
  end

  def channel do
    quote do
      alias NicLan.Repo

      @endpoint NicLan.Endpoint
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
