require 'spec_helper'

describe Klin::Partition do
  def node(id)
    Klin::Node.new(id)
  end

  let(:nodes) { [0, 1, 2, 3, 4, 5, 6, 7] }
  let(:edges) { [
    [0,5,120],
    [1,2,80],
    [2,7,30],
    [3,1,300],
    [4,3,100],
    [5,2,100],
    [6,0,100],
    [7,0,100]
  ] }

  subject(:partitioner) { described_class.new(nodes, edges) }

  let(:expected_partition) {
    [[node(1),node(2),node(3),node(4)], [node(0), node(5), node(6), node(7)]]
  }
  specify { expect(partitioner.calculate).to eql(expected_partition) }
end
