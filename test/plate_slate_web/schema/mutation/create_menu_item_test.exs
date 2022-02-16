defmodule PlateSlateWeb.Schema.Mutation.CreateMenuTest do
  use PlateSlateWeb.ConnCase, async: true

  alias PlateSlate.{Repo, Menu}
  import Ecto.Query

  setup do
    PlateSlate.Seeds.run()

    category_id =
      from(t in Menu.Category, where: t.name == "Sandwiches")
      |> Repo.one!
      |> Map.fetch!(:id)
      |> to_string

    {:ok, category_id: category_id}
  end

  @query """
  mutation ($menuItem: MenuItemInput!) {
    menuItem: createMenuItem(input: $menuItem) {
      name
      description
      price
    }
  }
  """
  test "createMenuItem field creates and item", %{category_id: category_id} do
    menu_item = %{
      "name" => "French Dip",
      "description" => "Roast beef, carmalized onions, horseradish, ...",
      "price" => "5.75",
      "categoryId" => category_id,
    }
    conn = build_conn()
    conn = post conn, "/api",
      query: @query,
      variables: %{"menuItem" => menu_item}

    assert json_response(conn, 200) == %{
      "data" => %{
          "menuItem" => %{
            "name" => menu_item["name"],
            "description" => menu_item["description"],
            "price" => menu_item["price"]
          }
        }
      }
  end
end
