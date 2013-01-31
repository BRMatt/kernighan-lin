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
