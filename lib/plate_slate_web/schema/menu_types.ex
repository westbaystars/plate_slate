defmodule PlateSlateWeb.Schema.MenuTypes do
  use Absinthe.Schema.Notation
  alias PlateSlateWeb.Resolvers

  @desc "Filtering options for the menu item list"
  input_object :menu_item_filter do
    @desc "Matching a name"
    field :name, :string

    @desc "Matching a category name"
    field :category, :string

    @desc "Matching a tag"
    field :tag, :string

    @desc "Priced above a value"
    field :priced_above, :decimal

    @desc "Priced below a value"
    field :priced_below, :decimal

    @desc "Added to the menu before this date"
    field :added_before, :date

    @desc "Added to the menu after this date"
    field :added_after, :date
  end

  object :menu_item do
    interfaces [:search_result]
    @desc "The internal ID of a given menu item"
    field :id, :id
    @desc "The name of the item on the menu"
    field :name, :string
    @desc "A description of the menu item"
    field :description, :string
    @desc "The cost of the menu item"
    field :price, :decimal
    @desc "The date added"
    field :added_on, :date
  end

  object :category do
    interfaces [:search_result]
    field :name, :string
    field :description, :string
    field :items, list_of(:menu_item) do
      resolve &Resolvers.Menu.items_for_category/3
    end
  end

  interface :search_result do
    field :name, :string
    resolve_type fn
      %PlateSlate.Menu.Item{}, _ -> :menu_item
      %PlateSlate.Menu.Category{}, _ -> :category
      _, _ -> nil
    end
  end

  input_object :menu_item_input do
    field :name, non_null(:string)
    field :description, :string
    field :price, non_null(:decimal)
    field :category_id, non_null(:id)
  end
end
