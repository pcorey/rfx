defmodule Rfx.Change.Req.TextReq do

  @moduledoc """
  Change.Req.Text struct and support functions.

  Edit elements - source file and diff.

  Change.Req.Text must have:
  - either *edit_path* or *edit_source*
  - *diff*

  Not using a struct here for now, in order to use the shorthand access syntax
  `edit[:diff]`.
  """

  alias Rfx.Util.Source

  # ----- Construction -----

  def new(file_path: path, diff: diff) do
    valid_struct = %{file_path: path, diff: diff}
    case File.exists?(path) do
      true ->  {:ok, valid_struct}
      _ -> {:error, "No file #{path}"}
    end
  end

  def new(edit_source: source, diff: diff) do
    valid_struct = %{edit_source: source, diff: diff}
    {:ok, valid_struct}
  end

  # ----- Application -----
  
  def apply!(%{file_path: path, diff: diff}) do
    new_source = path
                 |> File.read!()
                 |> Source.patch(diff)
    File.write(path, new_source)
    {:ok, "File #{path} updated with new content"}
  end

  def apply!(%{edit_source: _source, diff: _}) do
    {:error, "Can only apply changes to a file."}
  end

  # ----- Conversion -----

  def to_string(%{file_path: path, diff: diff}) do
    path 
    |> File.read!()
    |> Source.patch(diff)
  end

  def to_string(%{edit_source: source, diff: diff}) do
    source 
    |> Source.patch(diff)
  end

end