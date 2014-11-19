require 'spec_helper'

module MerchantsGuide
  module Number
    describe Intergalactic do
      context "with some symbols defined" do
        before(:each) do
          Intergalactic.add_symbol('glob', 'I')
          Intergalactic.add_symbol('prok', 'V')
          Intergalactic.add_symbol('pish', 'X')
          Intergalactic.add_symbol('tegj', 'L')
        end

        it "has the correct symbols hash" do
          expect(Intergalactic.symbols).to eq({ 'glob' => 'I', 'prok' => 'V', 'pish' => 'X', 'tegj' => 'L' })
        end

        describe "#digits" do
          { 'glob' => %w(glob), 'glob glob' => %w(glob glob), 'pish tegj glob glob' => %w(pish tegj glob glob) }.each do |intergalactic, digits|
            context "with #{intergalactic}" do
              subject { Intergalactic.new(intergalactic) }
              
              it "returns #{digits}" do
                expect(subject.digits).to eq(digits)
              end
            end
          end
        end

        describe "#to_i" do
          { 'glob' => 1, 'glob glob' => 2, 'glob glob glob' => 3, 'glob prok' => 4, 'prok glob' => 6, 'pish tegj glob glob' => 42 }.each do |intergalactic, arabic|
            context "with #{intergalactic}" do
              subject { Intergalactic.new(intergalactic) }
              
              it "returns #{arabic}" do
                expect(subject.to_i).to eq(arabic)
              end
            end
          end
        end

        describe "#to_roman" do
          { 'glob' => 'I', 'glob glob' => 'II', 'glob glob glob' => 'III', 'glob prok' => 'IV', 'prok glob' => 'VI', 'pish tegj glob glob' => 'XLII' }.each do |intergalactic, roman|
            context "with #{intergalactic}" do
              subject { Intergalactic.new(intergalactic) }
              
              it "returns #{roman}" do
                expect(subject.to_roman).to eq(Roman.new(roman))
              end
            end
          end
        end

        describe "#to_s" do
          ['glob', 'glob glob', 'glob glob glob', 'glob prok', 'prok glob', 'pish tegj glob glob'].each do |intergalactic|
            context "with #{intergalactic}" do
              subject { Intergalactic.new(intergalactic) }
              
              it "returns #{intergalactic}" do
                expect(subject.to_s).to eq(intergalactic)
              end
            end
          end
        end
      end
    end
  end
end