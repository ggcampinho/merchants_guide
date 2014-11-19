module MerchantsGuide
  module Support
    describe Routable do

      class MyClass
        include Routable

        add_route /\Aa\/(?<id>\d+)\z/, :method_a
        add_route /\Ab\/(?<id>\d+)\z/, :method_b
        add_route /\Ac\/(?<id>\d+)\/(?<text>.+)\z/, :method_c
      end

      subject { MyClass.new }

      context "MyClass" do
        subject { MyClass }

        it "has 3 routes" do
          expect(subject.router.routes.count).to eq(3)
        end
      end

      describe "#match_route" do
        context "with 'a/1'" do
          before(:each) { @match = subject.match_route('a/1') }

          it "matches returning :method_a" do
            expect(@match).to eq(:method_a)
          end

          it "has params equal { id: '1' }" do
            expect(subject.params).to eq({ id: '1' })
          end
        end

        context "with 'b/1'" do
          before(:each) { @match = subject.match_route('b/1') }

          it "matches returning :method_b" do
            expect(@match).to eq(:method_b)
          end

          it "has params equal { id: '1' }" do
            expect(subject.params).to eq({ id: '1' })
          end
        end

        context "with 'c/1/test'" do
          before(:each) { @match = subject.match_route('c/1/test') }

          it "matches returning :method_c" do
            expect(@match).to eq(:method_c)
          end

          it "has params equal { id: '1', text: 'test' }" do
            expect(subject.params).to eq({ id: '1', text: 'test' })
          end
        end

        context "with 'd/1'" do
          before(:each) { @match = subject.match_route('d/1') }

          it "doesn't match 'd/1'" do
            expect(subject.match_route('d/1')).to be_nil
          end

          it "has no params" do
            expect(subject.params.empty?).to be true
          end
        end
      end

      describe "#exec_route" do
        context "with 'a/1'" do
          it "executes #method_a" do
            expect(subject).to receive(:method_a).with(no_args)
            subject.exec_route('a/1')
          end
        end

        context "with 'd/1'" do
          it "not executes #method_a" do
            expect(subject).not_to receive(:method_a)
            subject.exec_route('d/1')
          end

          it "not executes #method_b" do
            expect(subject).not_to receive(:method_b)
            subject.exec_route('d/1')
          end

          it "not executes #method_c" do
            expect(subject).not_to receive(:method_c)
            subject.exec_route('d/1')
          end
        end
      end

    end
  end
end
