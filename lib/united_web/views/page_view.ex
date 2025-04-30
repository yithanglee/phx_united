defmodule UnitedWeb.PageView do
  use UnitedWeb, :view

  def firebase_config() do
    United.firebase_config()
  end
end

defmodule UnitedWeb.EmailView do
  use UnitedWeb, :view
end
