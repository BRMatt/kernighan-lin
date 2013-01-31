require_relative '../spec_helper'

describe Klin::Node do
  def node(id)
    described_class.new(id)
  end

  describe "#id" do
    specify { expect(node(:a).id).to eql(:a) }
  end

  describe "#==" do
    context "the same node" do
      subject(:the_node) { node(:a) }
      specify { expect(the_node == the_node).to be_true }
    end
    context "different instance of node, same id" do
      specify { expect(node(:a) == node(:a)).to be_true }
    end
    context "different instances, different ids" do
      specify { expect(node(:a) == node(:b)).to be_false }
    end
  end

  describe "#eql?" do
    context "the same node" do
      subject(:the_node) { node(:a) }
      specify { expect(the_node.eql? the_node).to be_true }
    end
    context "different instance of node, same id" do
      specify { expect(node(:a).eql? node(:a)).to be_true }
    end
    context "different instances, different ids" do
      specify { expect(node(:a).eql? node(:b)).to be_false }
    end
  end

  describe "#hash" do
    describe "#eql?" do
      context "the same node" do
        subject(:the_node) { node(:a) }
        specify { expect(the_node.hash).to be(the_node.hash) }
      end
      context "different instance of node, same id" do
        specify { expect(node(:a).hash).to be(node(:a).hash) }
      end
      context "different instances, different ids" do
        specify { expect(node(:a).hash).to_not be(node(:b).hash) }
      end
    end
  end

  describe "#inspect" do
    specify { expect(node(:a).inspect).to eql("Node(a)") }
  end
end

describe Klin::Edge do
  def node(id)
    Klin::Node.new(id)
  end
  def edge(source, target, cost)
    described_class.new(source, target, cost)
  end

  subject(:an_edge) { edge(:a, :b, 2) }

  describe "#source" do
    specify { expect(an_edge.source).to eql(node(:a)) }
  end

  describe "#target" do
    specify { expect(an_edge.target).to eql(node(:b)) }
  end

  describe "#to_edge" do
    specify { expect(an_edge).to be(an_edge) }
  end

  describe "#incident_to?" do
    context "when the edge is incident to the node" do
      specify { expect(an_edge).to be_incident_to(an_edge.source) }
      specify { expect(an_edge).to be_incident_to(an_edge.target) }
      specify { expect(an_edge).to be_incident_to(node(:a)) }
    end

    context "when the edge is not incident to the node" do
      specify { expect(an_edge).to_not be_incident_to(node(:c)) }
    end
  end

  describe "#nodes" do
    specify { expect(an_edge.nodes).to eql([an_edge.source, an_edge.target]) }
  end
end
