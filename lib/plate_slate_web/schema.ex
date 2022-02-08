defmodule PlateSlateWeb.Schema do
  use Absinthe.Schema
  alias PlateSlate.{Menu, Repo}

  query do
    @desc "The list of available items on the menu"
    field :menu_items, list_of(:menu_item) do
      resolve(fn _, _, _ ->
        {:ok, Repo.all(Menu.Item)}
      end)
    end
  end

  object :menu_item do
    @desc "The internal ID of a given menu item"
    field :id, :id
    @desc "The name of the item on the menu"
    field :name, :string
    @desc "A description of the menu item"
    field :description, :string
    @desc "The cost of the menu item"
    field :price, :float
  end
end
