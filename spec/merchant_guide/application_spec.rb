require 'spec_helper'

module MerchantsGuide
  describe Application do
    describe "#start" do

      %w(simple regular credits invalid).each do |input_type|
        context "with a #{input_type} input" do
          before(:each) do
            $stdin = File.open("spec/fixtures/inputs/#{input_type}.in")
            subject.start
          end

          it "reads all stdin" do
            expect($stdin.eof?).to be true
          end

          it "prints the correct output" do
            output = File.open("spec/fixtures/outputs/#{input_type}.out").read
            expect($stdout.string).to eq(output)
          end
        end
      end
    end
  end
end