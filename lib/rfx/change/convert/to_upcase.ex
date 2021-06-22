defmodule Rfx.Change.Convert.ToUpcase do

  # NEW

  alias Rfx.Util.Source

  def changelist(changelist) when is_list(changelist) do
    changelist
    |> Enum.map(&changereq/1)
  end

  def changereq(changereq) do
    tgt = changereq |> Map.get(:text_req)
    genlog = %{to_upcase: gen_string(tgt)}
    oldlog = Map.get(changereq, :log) || %{}
    oldcon = Map.get(oldlog, :convert) || %{}
    newcon = Map.merge(oldcon, genlog)
    newlog = Map.merge(oldlog, %{convert: newcon})
    Map.merge(changereq, %{log: newlog})
  end

  defp gen_string(%{file_path: path, diff: diff}) do
    path 
    |> File.read!()
    |> Source.patch(diff)
    |> String.upcase()
  end

  defp gen_string(%{edit_source: source, diff: diff}) do
    source 
    |> Source.patch(diff)
    |> String.upcase()
  end
end
