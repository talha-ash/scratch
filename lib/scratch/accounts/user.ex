defmodule Scratch.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Bcrypt, only: [hash_pwd_salt: 1]

  schema "users" do
    field :age, :integer
    field :email, :string
    field :password, :string
    field :fullname, :string
    field :username, :string
    field :roles, {:array, :string}, default: ["user"]
    field :password_one, :string, virtual: true
    field :password_two, :string, virtual: true
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :age, :email, :password, :fullname])
    |> validate_required([:username, :age, :email, :password, :fullname])
    |> unique_constraint(:email)
  end

  @doc false
  def registration_changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :age, :email, :password_one, :password_two])
    |> validate_required([:username, :email, :password_one, :password_two])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password_one, min: 3)
    |> validate_length(:password_two, min: 3)
    |> put_password_hash
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{
        valid?: true,
        changes: %{password_one: password_one, password_two: password_two}
      } ->
        changeset
        |> put_change(:password, hash_pwd_salt(password_one))

      _ ->
        changeset
    end
  end
end
