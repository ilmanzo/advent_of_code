class BreadthFirstSearch
    def initialize(graph, source_node)
      @graph = graph
      @node = source_node
      @visited = []
      @edge_to = {}
  
      bfs(source_node)
    end
  
    def shortest_path_to(node)
      return unless has_path_to?(node)
      path = []
  
      while(node != @node) do
        path.unshift(node) # unshift adds the node to the beginning of the array
        node = @edge_to[node]
      end
  
      path.unshift(@node)
    end
  
    private
    def bfs(node)
      # Remember, in the breadth first search we always
      # use a queue. In ruby we can represent both
      # queues and stacks as an Array, just by using
      # the correct methods to deal with it. In this case,
      # we use the "shift" method to remove an element
      # from the beginning of the Array.
  
      # First step: Put the source node into a queue and mark it as visited
      queue = []
      queue << node
      @visited << node
  
      # Second step: Repeat until the queue is empty:
      # - Remove the least recently added node n
      # - add each of n's unvisited adjacents to the queue and mark them as visited
      while queue.any?
        current_node = queue.shift # remove first element
        @graph[current_node].each do |adjacent_node|
          next if @visited.include?(adjacent_node)
          queue << adjacent_node
          @visited << adjacent_node
          @edge_to[adjacent_node] = current_node
        end
      end
    end
  
    # If we visited the node, so there is a path
    # from our source node to it.
    def has_path_to?(node)
      @visited.include?(node)
    end
  end

graph={}
input=ARGF.readlines(chomp:true).map do |line|
    items=line.split ':'
    key=items[0]
    values=items[1].split
    graph[key]=values
end
p graph
bfs=BreadthFirstSearch.new(graph,'rsh')
p bfs.has_path_to?('ntq')


