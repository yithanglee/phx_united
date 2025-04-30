defmodule UnitedWeb.LayoutView do
  use UnitedWeb, :view

  def format_library_name(library_name) do
    # Extract the first character and the rest of the string
    [first_letter | rest] =
      library_name |> String.split("") |> Enum.reject(&(&1 == "")) |> IO.inspect()

    rest_string = Enum.join(rest, "")

    # Construct the HTML string
    html_output = """
    <span class='sm-txt'>#{first_letter}</span><span>#{rest_string}</span>
    """

    html_output |> raw()
  end
end
