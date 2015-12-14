require "rspec/autorun"
load "graph.rb"

describe Graph do
  describe "#outgoing" do
    it "returns the outgoing edges" do
      g = Graph.new([[1, 2], [2, 3], [3, 4], [2, 5]])

      expect(g.outgoing(2)).to include [2, 3], [2, 5]
    end
  end

  describe "#incoming" do
    it "returns the incoming edges" do
      g = Graph.new([[1, 2], [2, 3], [3, 4], [2, 5], [5, 2]])

      expect(g.incoming(2)).to include [1, 2], [5, 2]
    end
  end

  describe "#next_nodes" do
    it "returns the next nodes" do
      g = Graph.new([[1, 2], [2, 3], [3, 4], [2, 5]])

      expect(g.next_nodes(2)).to include 3, 5
    end
  end

  describe "#previous_nodes" do
    it "returns the previous nodes" do
      g = Graph.new([[1, 2], [2, 3], [3, 4], [2, 5], [5, 2]])

      expect(g.previous_nodes(2)).to include 1, 5
    end
  end

  describe "#topological_sort" do
    it "topologically sorts the nodes of the graph" do
      g = Graph.new([
        [3, 8],
        [3, 10],
        [5, 11],
        [7, 8],
        [7, 11],
        [8, 9],
        [11, 2],
        [11, 9],
        [11, 10]
      ])

      expected = [3, 5, 7, 8, 11, 10, 9, 2]

      expect(g.topological_sort).to eq(expected)
    end

    it "raises an UnsortableCyclicGraphError when the graph has cycles" do
      g = Graph.new([
        [1, 2],
        [2, 1]
      ])
      expect { g.topological_sort }.to raise_error(UnsortableCyclicGraphError)
    end
  end
end
