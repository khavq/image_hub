defmodule ImageHub.AccountsTest do
  use ImageHub.DataCase

  alias ImageHub.Accounts

  describe "users" do
    alias ImageHub.Accounts.User

    @valid_attrs %{avatar_url: "some avatar_url", email: "some email", name: "some name", phone_number: "some phone_number", password: "some password"}
    @update_attrs %{avatar_url: "some updated avatar_url", email: "some updated email", name: "some updated name", phone_number: "some updated phone_number"}
    @invalid_attrs %{avatar_url: nil, email: nil, name: nil, phone_number: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert {:ok, user} = Argon2.check_pass(user, "some password", hash_key: :password)
      assert user.avatar_url == "some avatar_url"
      assert user.email == "some email"
      assert user.name == "some name"
      assert user.phone_number == "some phone_number"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.avatar_url == "some updated avatar_url"
      assert user.email == "some updated email"
      assert user.name == "some updated name"
      assert user.phone_number == "some updated phone_number"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  #describe "credentials" do
    #alias ImageHub.Accounts.Credential

    #@valid_attrs %{password: "some password", role: "some role"}
    #@update_attrs %{password: "some updated password", role: "some updated role"}
    #@invalid_attrs %{password: nil, role: nil}

    #def credential_fixture(attrs \\ %{}) do
      #{:ok, credential} =
        #attrs
        #|> Enum.into(@valid_attrs)
        #|> Accounts.create_credential()

      #credential
    #end

    #test "list_credentials/0 returns all credentials" do
      #credential = credential_fixture()
      #assert Accounts.list_credentials() == [credential]
    #end

    #test "get_credential!/1 returns the credential with given id" do
      #credential = credential_fixture()
      #assert Accounts.get_credential!(credential.id) == credential
    #end

    #test "create_credential/1 with valid data creates a credential" do
      #assert {:ok, %Credential{} = credential} = Accounts.create_credential(@valid_attrs)
      #assert credential.password == "some password"
      #assert credential.role == "some role"
    #end

    #test "create_credential/1 with invalid data returns error changeset" do
      #assert {:error, %Ecto.Changeset{}} = Accounts.create_credential(@invalid_attrs)
    #end

    #test "update_credential/2 with valid data updates the credential" do
      #credential = credential_fixture()
      #assert {:ok, %Credential{} = credential} = Accounts.update_credential(credential, @update_attrs)
      #assert credential.password == "some updated password"
      #assert credential.role == "some updated role"
    #end

    #test "update_credential/2 with invalid data returns error changeset" do
      #credential = credential_fixture()
      #assert {:error, %Ecto.Changeset{}} = Accounts.update_credential(credential, @invalid_attrs)
      #assert credential == Accounts.get_credential!(credential.id)
    #end

    #test "delete_credential/1 deletes the credential" do
      #credential = credential_fixture()
      #assert {:ok, %Credential{}} = Accounts.delete_credential(credential)
      #assert_raise Ecto.NoResultsError, fn -> Accounts.get_credential!(credential.id) end
    #end

    #test "change_credential/1 returns a credential changeset" do
      #credential = credential_fixture()
      #assert %Ecto.Changeset{} = Accounts.change_credential(credential)
    #end
  #end
end
