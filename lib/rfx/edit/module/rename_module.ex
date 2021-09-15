defmodule Rfx.Edit.Module.RenameModule do
  @moduledoc """
  Rename module.
  """

  @behaviour Rfx.Edit

  @impl true

  @doc """
  Rename Module
  """
  def edit(input_source, new_name: new_name, old_name: old_name) do
    input_source
    |> String.replace(old_name, new_name)
  end
end
