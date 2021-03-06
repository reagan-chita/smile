defmodule Smile.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Welcome.Accounts.{User, Encryption}

  schema "users" do
    field :email, :string
    field :name, :string
    field :password_hash, :string
    ## virtual field ##
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @required_field ~w(email name password)
  @optional_field ~w()

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 6)
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> encrypt_password
  end

  defp encrypt_password(changeset) do
    password = get_change(changeset, :password)

    if password do
      encrypted_password = Encryption.hash_password(password)
      put_change(changeset, :password_hash, encrypted_password)
    else
      changeset
    end
  end
end
