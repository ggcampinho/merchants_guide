module MerchantsGuide
  module Support
    describe Router do
      it "contains no routes" do
        expect(subject.routes.size).to eq(0)
      end

      it "contains no not found route" do
        expect(subject.not_found_route).to be_nil
      end
    end
  end
end
