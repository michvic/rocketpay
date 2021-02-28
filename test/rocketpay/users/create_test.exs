defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase,  async: true

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = %{
        name: "Michel",
        password: "123456",
        nickname: "mich",
        email: "mich@teste.com",
        age: 22
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Michel", age: 22, id: ^user_id} = user
    end

    test "when there are invalid, returns an user" do
      params = %{
        name: "Michel",
        nickname: "mich",
        email: "mich@teste.com",
        age: 15
      }

      {:error, changeset} = Create.call(params)

      expected_respose = %{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }

      assert errors_on(changeset) == expected_respose
    end
  end
end
