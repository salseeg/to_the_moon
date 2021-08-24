defmodule ToTheMoon do
  @moduledoc """
  Documentation for `ToTheMoon`.
  """

  @doc """
  Calculates fuel needed for trip
  """
  def fuel_weight(cargo_weight, path) do
    steps_fuel_weight(cargo_weight, Enum.reverse(path)) - cargo_weight
  end

  @doc """
    Goes through steps adding fuel needed for each step as cargo for next one
  """
  def steps_fuel_weight(cargo, []), do: cargo

  def steps_fuel_weight(cargo, [step | rest_path]) do
    steps_fuel_weight(cargo + ToTheMoon.Fuel.weight(cargo, step), rest_path)
  end
end
