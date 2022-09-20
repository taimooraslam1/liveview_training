defmodule LiveviewWeb.FilterLive do
  use LiveviewWeb, :live_view

  alias Liveview.Boats

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        boats: Boats.list_boats(),
        type: "",
        price: []
      )
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1 class="mt-12">Daily Boat Rentals</h1>
    <div id="filter">
      <form phx-change="filter">
        <div class="filters">
          <select name="type">
            <%= options_for_select(type_options(), @type) %>
          </select>
        </div>
      </form>
      <div class="boats">
      <%= for boat <- @boats do %>
        <div class="card" id="">
          <img src="<%= boat.image %>" alt="">
          <div class="content">
            <div class="model"><%= boat.model %></div>
            <div class="details">
              <span class="price"><%= boat.price %></span>
              <span class="type"><%= boat.type %></span>
            </div>
          </div>
        </div>
      <% end %>
      </div>
    </div>

    """
  end

  def handle_event("filter", %{"type" => type}, socket) do
    boats = Boats.list_boats(type: type)
    socket = assign(socket, boats: boats, type: type)
    {:noreply, socket}
  end

  defp type_options do
    [
      "All Types": "",
      Fishing: "fishing",
      Sporting: "sporting",
      Sailing: "sailing",
    ]
  end

end
