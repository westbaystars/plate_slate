defmodule PlateSlateWeb.Schema do
  use Absinthe.Schema
  alias PlateSlate.{Menu, Repo}
  alias PlateSlateWeb.Resolvers

  query do
    @desc "The list of available items on the menu"
    field :menu_items, list_of(:menu_item) do
      arg :matching, :string
      resolve &Resolvers.Menu.menu_items/3
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
