defmodule LiveviewWeb.TestLive do
  use LiveviewWeb, :live_view
  def mount(_params, _session, socket) do
    # IO.puts "MOUNT: Proccess id #{inspect(self())}"
    socket = assign(socket, :brightness, 10)
    {:ok, socket}
  end

  def render(assigns) do
    # IO.puts "RENDER: Proccess id #{inspect(self())}"
    ~L"""
    <h1 class="mt-5"><%= @brightness %></h1>
    <div id="light">
      <div class="meter">
        <span style="width: <%= @brightness %>%">
          <%= @brightness %>
        </span>
      </div>
      <button class="" phx-click="off">
        <img src="images/light-off.svg" alt="off-btn"/>
      </button>
      <button class="" phx-click="down">
        <img src="images/down.svg" alt="down-btn"/>
      </button>
      <button class="" phx-click="up">
        <img src="images/up.svg" alt="up-btn"/>
      </button>
      <button class="" phx-click="on">
        <img src="images/light-on.svg" alt="on-btn"/>
      </button>
    </div>
    """
  end

  def handle_event("on", _, socket) do
    # IO.puts "ON: Proccess id #{inspect(self())}"
    socket = assign(socket, :brightness, 100)
    {:noreply, socket}
  end

  def handle_event("off", _, socket) do
    socket = assign(socket, :brightness, 0)
    {:noreply, socket}
  end

  def handle_event("up", _, socket) do
    socket = update(socket, :brightness, &(&1 + 10))
    {:noreply, socket}
  end

  def handle_event("down", _, socket) do
    socket = update(socket, :brightness, &(&1 - 10))
    {:noreply, socket}
  end
end
