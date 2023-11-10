defmodule Stack.Stash do
  use GenServer
  
  @me __MODULE__
  
  #####
  # 외부 API
  def start_link(current_list) do
    GenServer.start_link(__MODULE__, current_list, name: @me)
  end
  
  def get() do
    GenServer.call(@me, { :get })
  end
  
  def update(current_list) do
    GenServer.cast(@me, {:update, current_list})
  end
  
  def init(initial_number) do
    { :ok, initial_number }
  end
  
  def handle_call({:get}, _from, current_list) do
    {:reply, current_list, current_list}
  end
  
  def handle_cast({:update, current_list}, _current_number) do
    {:noreply, current_list}
  end
  
end
