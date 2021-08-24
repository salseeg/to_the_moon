defmodule ToTheMoon.Fuel do
  @doc """
    Calculates initial fuel weight for mass

    iex> ToTheMoon.Fuel.initial_weight(28801, {:land, 9.807})
    9278

  """
  def initial_weight(mass, {:land, gravity}) do
    (mass * gravity * 0.033 - 42)
    |> trunc
    |> max(0)
  end

  def initial_weight(mass, {:launch, gravity}) do
    (mass * gravity * 0.042 - 33)
    |> trunc
    |> max(0)
  end

  @doc """
  Calculates fuel weight for mass and added fuel

    iex> ToTheMoon.Fuel.weight(28801, {:land, 9.807})
    13447

  """
  def weight(mass, step) do
    weight(mass, step, 0)
  end

  @doc """
  Calculates fuel weight correction, since extra fuel adds extra weight
  """
  def weight(0 = _mass, _step, sum), do: sum

  def weight(mass, step, sum) do
    fuel = initial_weight(mass, step)

    weight(fuel, step, fuel + sum)
  end
end
