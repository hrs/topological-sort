UnsortableCyclicGraphError = Class.new(StandardError)

class Graph
  attr_reader :edges, :nodes

  def initialize(edges, nodes = [])
    @edges = edges
    @nodes = (nodes + edges.flatten).uniq
  end

  def topological_sort
    if nodes.empty?
      []
    else
      start_nodes = nodes.select { |n| incoming(n).empty? }
      if start_nodes.empty?
        raise UnsortableCyclicGraphError
      end
      removed_edges = start_nodes.map { |n| outgoing(n) }.flatten(1)

      unsorted_graph = Graph.new(edges - removed_edges, nodes - start_nodes)

      start_nodes + unsorted_graph.topological_sort
    end
  end

  def cyclic?
    topological_sort
    false
  rescue UnsortableCyclicGraphError
    true
  end

  def outgoing(node)
    edges.select { |e| node == from(e) }
  end

  def incoming(node)
    edges.select { |e| node == to(e) }
  end

  def next_nodes(node)
    outgoing(node).map { |e| to(e) }
  end

  def previous_nodes(node)
    incoming(node).map { |e| from(e) }
  end

  private

  def from(edge)
    edge.first
  end

  def to(edge)
    edge.last
  end
end
