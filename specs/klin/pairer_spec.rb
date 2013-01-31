require_relative '../spec_helper'

describe Klin::Pairer do
  Node = Struct.new(:id)

  let(:pairer) { described_class.new }
  let(:a_nodes) { [Node.new(:foo), Node.new(:bar)] }
  let(:b_nodes) { [Node.new(:me), Node.new(:you)] }
  let(:all_pairs) do
    [
      [a_nodes[0], b_nodes[0]],
      [a_nodes[0], b_nodes[1]],
      [a_nodes[1], b_nodes[0]],
      [a_nodes[1], b_nodes[1]]
    ]
  end

  describe "#pairs" do
    subject { pairer.pairs(a_nodes, b_nodes, ignored_nodes) }

    context "no nodes are ignored" do
      let(:ignored_nodes) { [] }

      it { should eql(all_pairs) }
    end

    context "specific nodes are ignored" do
      let(:ignored_nodes) { [b_nodes[1]] }
      let(:ignored_pairs) { [[a_nodes[0], b_nodes[1]], [a_nodes[1], b_nodes[1]]] }

      it { should eql(all_pairs - ignored_pairs) }
    end
  end
end
