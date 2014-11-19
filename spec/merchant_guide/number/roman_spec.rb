require 'spec_helper'

module MerchantsGuide
  module Number
    describe Roman do
      describe "#digits" do
        { 'I' => %w(I), 'II' => %w(I I), 'XLII' => %w(X L I I) }.each do |roman, digits|
          context "with #{roman}" do
            subject { Roman.new(roman) }
            
            it "returns #{digits}" do
              expect(subject.digits).to eq(digits)
            end
          end
        end
      end

      describe "#to_roman" do
        %w(I II XLII).each do |roman|
          context "with #{roman}" do
            subject { Roman.new(roman) }
            
            it "is equal to itself" do
              expect(subject.to_roman).to eq(subject)
            end
          end
        end
      end

      describe "#==" do
        %w(I II XLII).each do |roman|
          context "with #{roman}" do
            subject { Roman.new(roman) }
            
            it "is equal to other roman #{roman}" do
              expect(subject).to eq(Roman.new(roman))
            end

            it "is equal an object duck typing to_roman #{roman}" do
              obj = double()
              allow(obj).to receive(:to_roman).and_return(Roman.new(roman))
              expect(subject).to eq(obj)
            end

            it "isn't equal to 'X'" do
              expect(subject).to_not eq(Roman.new('X'))
            end
          end
        end
      end

      describe "#to_i" do
        { 'I' => 1, 'II' => 2, 'III' => 3, 'IV' => 4, 'VI' => 6, 'XXXIX' => 39, 'MCMXLIV' => 1944 }.each do |roman, arabic|
          context "with #{roman}" do
            subject { Roman.new(roman) }
            
            it "returns #{arabic}" do
              expect(subject.to_i).to eq(arabic)
            end
          end
        end
      end
    end
  end
end