defmodule RdaThree.Schema.UserTest do
  use ExUnit.Case
  alias Ecto.Changeset
  alias RdaThree.Users.User

  @expected_fields_with_types [
    {:id, :binary_id},
    {:biography, :string},
    {:full_name, :string},
    {:gender, :string},
    {:account_id, :binary_id},
    {:inserted_at, :naive_datetime},
    {:updated_at, :naive_datetime}
  ]

  @optional [:id, :inserted_at, :updated_at]

  describe "fields and types" do
    test "it has the correct fields and types" do
      actual_fields_with_types =
        for field <- User.__schema__(:fields) do
          type = User.__schema__(:type, field)
          {field, type}
        end

      assert MapSet.new(actual_fields_with_types) == MapSet.new(@expected_fields_with_types)
    end
  end

  describe "changeset/2" do
    test "success: returns valid changeset when given valid arguments" do
      valid_params = %{
        "id" => Ecto.UUID.generate(),
        "biography" => "some bio",
        "full_name" => "Alan Smith",
        "gender" => "male",
        "account_id" => Ecto.UUID.generate(),
        "inserted_at" => NaiveDateTime.local_now(),
        "updated_at" => NaiveDateTime.local_now()
      }

      changeset = User.changeset(%User{}, valid_params)

      assert %Changeset{valid?: true, changes: changes} = changeset

      for {field, _} <- @expected_fields_with_types do
        actual = Map.get(changes, field)
        expected = valid_params[Atom.to_string(field)]

        assert actual == expected,
               "Values did not match for field: #{field}\nexpected: #{inspect(expected)}\nactual: #{inspect(actual)}"
      end
    end

    test "error: returns an error changeset when given un-castable values" do
      invalid_params = %{
        "id" => NaiveDateTime.local_now(),
        "biography" => NaiveDateTime.local_now(),
        "full_name" => NaiveDateTime.local_now(),
        "gender" => NaiveDateTime.local_now(),
        "account_id" => NaiveDateTime.local_now(),
        "inserted_at" => "soms stying",
        "updated_at" => "soms stying sewcf"
      }

      assert %Changeset{valid?: false, errors: errors} =
               User.changeset(%User{}, invalid_params)

      for {field, _} <- @expected_fields_with_types do
        assert errors[field], "The field: #{field} is missing from errors."

        {_, meta} = errors[field]

        assert meta[:validation] == :cast,
               "The validation type, #{meta[:validation]}, is incorrect."
      end
    end

    test "error: returns an error changeset when required fields are missing" do
      params = %{}

      assert %Changeset{valid?: false, errors: errors} =
               User.changeset(%User{}, params)

      for {field, _} <- @expected_fields_with_types, field not in @optional do
        assert errors[field], "The field: #{field} is missing from errors."

        {_, meta} = errors[field]

        assert meta[:validation] == :required,
               "The validation type, #{meta[:validation]}, is incorrect."
      end

      for field <- @optional do
        refute errors[field], "The optional field #{field} is required when it shouldn't be."
      end
    end
  end
end
