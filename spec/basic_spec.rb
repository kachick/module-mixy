# coding: us-ascii

require_relative 'helper'

describe Module::Mixy do
  before(:each) do
    @class = Class.new do
      extend Module::Mixy
    end
  end

  describe "#mixy" do
    it "is a public method" do
      expect(@class.public_methods).to include(:mixy)
    end

    it "returns self" do
      expect(@class.mixy HasPublicAndPrivate).to equal(@class)
    end

    it "extends self with the features" do
      @class.mixy HasPublicAndPrivate
      expect(@class.public_instance_methods).to include(:public_func)
      expect(@class.new.public_func).to eq(:ret_public_func_on_has_public_and_private)
      expect(@class.private_instance_methods).to include(:private_func)
      expect(@class.new.__send__(:private_func)).to eq(:ret_private_func_on_has_public_and_private)
    end

    it "does not extend with ancestors of the module" do
      @class.mixy HasPublicAndPrivate
      instance = @class.new
      expect { instance.__send__(:not_want) }.to raise_error(NoMethodError)
    end

    context "when the module has same method-name" do
      before(:each) do
        @class.mixy HasPublicAndPrivate
      end

      context "the method visibility is public" do
        it "raises a ConflictError" do
          expect do
            @class.mixy HasPublic
          end.to raise_error(Module::Mixy::ConflictError)
        end

        it "extends self with aliased name" do
          @class.mixy HasPublic, :public_func => :public_func_aliased
          expect(@class.public_instance_methods).to include(:public_func_aliased)
          expect(@class.new.public_func_aliased).to eq(:ret_public_func_on_has_public)
          expect(@class.new.public_func).to eq(:ret_public_func_on_has_public_and_private)
        end
      end

      context "the method visibility is private" do
        it "raises a ConflictError" do
          expect do
            @class.mixy HasPrivate
          end.to raise_error(Module::Mixy::ConflictError)
        end

        it "extends self with aliased name" do
          @class.mixy HasPrivate, :private_func => :private_func_aliased
          expect(@class.private_instance_methods).to include(:private_func_aliased)
          expect(@class.new.__send__(:private_func_aliased)).to eq(:ret_private_func_on_has_private)
          expect(@class.new.__send__(:private_func)).to eq(:ret_private_func_on_has_public_and_private)
        end
      end
    end
  end

  describe Module::Mixy::ConflictError do
    it "is a subclass of NameError" do
      expect(Module::Mixy::ConflictError.superclass).to equal(NameError)
    end
  end
end