require 'spec_helper'

module MerchantsGuide
  describe Metric do
    let(:metric_a) { Metric.new('A', 1, 2) }
    let(:metric_b) { Metric.new('A', 3, 10) }

    describe "#convert" do
      it "converts 3 A to 6" do
        expect(metric_a.convert(3)).to eq(6)
      end

      it "converts 3 B to 10" do
        expect(metric_b.convert(3)).to eq(10)
      end
    end

    context "with some metrics defined" do
      before(:each) do
        Metric.add('A', 1, 2)
        Metric.add('B', 3, 10)
      end

      describe "#self.convert" do
        it "converts 3 A to 6" do
          expect(Metric.convert('A', 3)).to eq(6)
        end

        it "converts 3 B to 10" do
          expect(Metric.convert('B', 3)).to eq(10)
        end
      end
    end
  end
end