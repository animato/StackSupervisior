defmodule Stack.Server do
  use GenServer
  
  #####
  # 외부 API
  def start_link(_) do
    IO.puts "start_link"
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end
  
  def pop() do
    GenServer.call __MODULE__, :pop
  end
  
  def push(element) do
    GenServer.cast __MODULE__, {:push, element}
  end
  
  def init(_) do
    IO.puts "init"
    { :ok, Stack.Stash.get }
  end
  
  # 연습문제 17-1 
  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end
  
  # 연습문제 17-2
  def handle_cast({:push, element}, current_stack) do
    {:noreply, [element | current_stack]}
  end
  
  def terminate(reason, current_number) do
    IO.puts "terminate"
    # IO.puts reason
    # IO.puts current_number
    Stack.Stash.update(current_number)
  end
end
