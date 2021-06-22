defmodule Rfx.Catalog.OpsCat do
  @moduledoc """
  Dynamically generate a catalog of Rfx Operations.

  Introspects the BEAM environment for all modules in the `Rfx.Ops.` namespace.

  Used to generate dynamic a catalog of Rfx Operations.  Developers can write
  their own Rfx Operations, and apply introspection mechanisms comparable those
  used for Mix Tasks.

  The Catalog is used by `rfxi` to generate generate a list of Rfx Operation
  modules.
  """

  alias Rfx.Util.Introspect

  @doc """
  Return a list of all Rfx.Ops modules available in the Beam.
  """
  def all_ops do
    raw_ops()
    |> Enum.filter(&has_argspec?/1)
  end

  @doc """
  Select Rfx operations in a given namespace.
  """
  def select_ops(namespace \\ "") do
    raw_ops(namespace)
    |> Enum.filter(&has_argspec?/1)
  end

  def raw_ops(namespace \\ "") do
    Introspect.modules_belonging_to_namespace("Rfx.Ops." <> namespace)
  end

  defp has_argspec?(module) do
    module
    |> Introspect.has_function?({:argspec, 0})
  end

end
