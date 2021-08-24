defmodule ToTheMoonTest do
  use ExUnit.Case

  doctest ToTheMoon
  doctest ToTheMoon.Fuel

  test "Apollo 11" do
    cargo_weight = 28801

    path = [
      {:launch, 9.807},
      {:land, 1.62},
      {:launch, 1.62},
      {:land, 9.807}
    ]

    assert ToTheMoon.fuel_weight(cargo_weight, path) == 51898
  end

  test "Mars" do
    cargo_weight = 14606

    path = [
      {:launch, 9.807},
      {:land, 3.711},
      {:launch, 3.711},
      {:land, 9.807}
    ]

    assert ToTheMoon.fuel_weight(cargo_weight, path) == 33388
  end

  test "Passenger" do
    cargo_weight = 75432

    path = [
      {:launch, 9.807},
      {:land, 1.62},
      {:launch, 1.62},
      {:land, 3.711},
      {:launch, 3.711},
      {:land, 9.807}
    ]

    assert ToTheMoon.fuel_weight(cargo_weight, path) == 212_161
  end
end
