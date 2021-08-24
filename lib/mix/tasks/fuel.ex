defmodule Mix.Tasks.Fuel do
  @moduledoc """
    Calculates fuel needed to travel between planets.
    Args on format:
      cargo_weight [land/launch gravity]...

    For Apollo 11 mission it would be
      28801 launch 9.807 land 1.62 launch 1.62 land 9.807
  """
  @shortdoc "Fuel weight needed to deliver cargo with planet route"

  use Mix.Task

  @impl Mix.Task
  def run(args) do
    with {:ok, {cargo, path}} <- parse(args) do
      fuel = ToTheMoon.fuel_weight(cargo, path)

      Mix.shell().info("""
        Cargo: #{cargo} kg
        Path:  #{inspect(path)}

        Fuel:  #{fuel} kg
      """)
    else
      {:error, err} -> Mix.shell().error(err)
      _ -> Mix.shell().error("Unable to parse arguments")
    end
  end

  def parse([]), do: {:error, "Error parsing arguments. Please check `mix help fuel`"}

  def parse([raw_cargo | raw_path]) do
    with {cargo, _} when is_integer(cargo) <- Integer.parse(raw_cargo),
         {:ok, path} <- parse_path(raw_path, []) do
      {:ok, {cargo, path}}
    else
      _ -> {:error, "Error parsing arguments. Please check `mix help fuel`"}
    end
  end

  def parse_path([], acc), do: {:ok, Enum.reverse(acc)}

  def parse_path(["land" | [gravity | rest]], acc),
    do: parse_path(rest, [{:land, gravity |> Float.parse() |> elem(0)} | acc])

  def parse_path(["launch" | [gravity | rest]], acc),
    do: parse_path(rest, [{:launch, gravity |> Float.parse() |> elem(0)} | acc])

  def parse_path(_, _), do: :error
end
