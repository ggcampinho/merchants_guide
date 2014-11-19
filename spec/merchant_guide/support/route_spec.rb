require 'spec_helper'

module MerchantsGuide
  module Support
    describe Route do
      let(:route_a) { Route.new(/\Aa\/(?<id>\d+)\z/, :route_a) }
      let(:route_b) { Route.new(/\Ab\/(?<id>\d+)\z/, :route_b) }
      let(:route_c) { Route.new(/\Ac\/(?<id>\d+)\/(?<text>.+)\z/, :route_c) }

      describe "#=~" do
        context "with :route_a" do
          subject { route_a }

          it "matches 'a/1' returning 0" do
            expect(subject =~ 'a/1').to eq(0)
          end

          it "doesn't match 'b/1'" do
            expect(subject =~ 'b/1').to be_nil
          end
        end

        context "with :route_b" do
          subject { route_b }

          it "matches 'b/1' returning 0" do
            expect(subject =~ 'b/1').to eq(0)
          end

          it "doesn't match 'a/1'" do
            expect(subject =~ 'a/1').to be_nil
          end
        end
      end

      describe "#match" do
        context "with :route_a" do
          subject { route_a }

          it "matchs 'a/1' returning { id: '1' }" do
            expect(subject.match('a/1')).to eq({id: '1'})
          end

          it "doens't match 'b/1'" do
            expect(subject.match('b/1')).to be_nil
          end
        end

        context "with :route_c" do
          subject { route_c }

          it "matchs 'c/1/test' returning { id: '1', text: 'test' }" do
            expect(subject.match('c/1/test')).to eq({id: '1', text: 'test'})
          end
        end
      end
    end
  end
end
