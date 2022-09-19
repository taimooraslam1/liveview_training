defmodule LiveviewWeb.LicenseLive do
  use LiveviewWeb, :live_view

  alias Liveview.Licenses

  def mount(_params, _session, socket) do
    socket = assign(socket, seats: 2, amount: Licenses.calculate(2))
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1 class="mt-10">Team License</h1>
    <div id="license">
      <div class="card">
        <div class="content">
          <div class="seats">
            <img src="images/license.svg"/>
            <span>Your license for currently <strong><%= @seats %></strong> seates</span>
          </div>
          <form phx-change="update">
            <input type="range" min="1" max="10" name="seats" value="<%= @seats %>" />
          </form>
          <div class="amount"><%= @amount %></div>
        </div>
      </div>
    </div>
    """
  end

  def handle_event("update", %{"seats" => seats}, socket) do
    seats = String.to_integer(seats)
    socket = assign(socket, seats: seats, amount: Licenses.calculate(seats))
    {:noreply, socket}
  end

end
