require 'spec_helper'

describe Klin::NodeWeightings do
  def node(id)
    Klin::Node.new(id)
  end
  def edge(source, target, cost)
    Klin::Edge.new(source, target, cost)
  end

  let(:nodes) { [node(:a), node(:b), node(:c), node(:d)] }
  let(:edges) { [edge(:a, :b, 2), edge(:a, :c, 10), edge(:b, :c, 4), edge(:c, :d, 1)] }
  let(:node_edges) { Klin::Partition.denormalize_edges(edges) }
  subject(:calculated_weights) do
    described_class
      .new(nodes, node_edges)
      .calculate(partition_a, partition_b)
  end

  describe "#calculate" do
    let(:partition_a) { [node(:a), node(:b)] }
    let(:partition_b) { [node(:c), node(:d)] }
    let(:expected_weights) do
      {
        node(:a) => 8, node(:b) => 2, node(:c) => 13, node(:d) => -1
      }
    end


    specify { expect(calculated_weights).to eql(expected_weights) }
  end
end
