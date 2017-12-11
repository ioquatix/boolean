require 'spec_helper'

describe TrueClass do
  [ :to_bool, :parse_bool, :to_b ].each do |method|
    describe "##{method}" do
      it("should return true") { expect(true.send(method)).to eql(true) }
    end
  end

  it("should be a kind of Boolean") { expect(true).to be_kind_of(Boolean) }
end

describe FalseClass do
  [ :to_bool, :parse_bool, :to_b ].each do |method|
    describe "##{method}" do
      it("should return false") { expect(false.send(method)).to eql(false) }
    end
  end

  it("should be a kind of Boolean") { expect(false).to be_kind_of(Boolean) }
end

describe NilClass do
  [ :to_bool, :parse_bool, :to_b ].each do |method|
    describe "##{method}" do
      it("should return false") { expect(nil.send(method)).to eql(false) }
    end
  end
end

describe Object do
  describe "#to_bool" do
    it("should return true") { expect(Object.new.to_bool).to eql(true) }
  end

  it("should not be a kind of Boolean") { expect(Object.new).not_to be_kind_of(Boolean) }
end

describe Numeric do
  [ :parse_bool, :to_b ].each do |method|
    describe "##{method}" do
      it "should return true if the number is not zero" do
        expect(1.send(method)).to eql(true)
        expect(1.0.send(method)).to eql(true)
        expect(-1.send(method)).to eql(true)
        expect(-1.0.send(method)).to eql(true)
      end

      it "should return false if the number is zero" do
        expect(0.send(method)).to eql(false)
        expect(0.0.send(method)).to eql(false)
      end
    end
  end
end

describe String do
  [ :parse_bool, :to_b ].each do |method|
    describe "##{method}" do
      it "should return true if the string starts with 1, y, Y, t, or T" do
        expect("y".send(method)).to eql(true)
        expect("Y".send(method)).to eql(true)
        expect("yes".send(method)).to eql(true)
        expect("YES".send(method)).to eql(true)
        expect("Yes".send(method)).to eql(true)
        expect("t".send(method)).to eql(true)
        expect("T".send(method)).to eql(true)
        expect("true".send(method)).to eql(true)
        expect("TRUE".send(method)).to eql(true)
        expect("True".send(method)).to eql(true)
        expect("1".send(method)).to eql(true)
      end

      it "should return false otherwise" do
        expect("n".send(method)).to eql(false)
        expect("N".send(method)).to eql(false)
        expect("no".send(method)).to eql(false)
        expect("NO".send(method)).to eql(false)
        expect("No".send(method)).to eql(false)
        expect("f".send(method)).to eql(false)
        expect("F".send(method)).to eql(false)
        expect("false".send(method)).to eql(false)
        expect("FALSE".send(method)).to eql(false)
        expect("False".send(method)).to eql(false)
        expect("0".send(method)).to eql(false)
        expect("".send(method)).to eql(false)

        expect("m".send(method)).to eql(false)
        expect("maybe".send(method)).to eql(false)
        expect("MAYBE".send(method)).to eql(false)
        expect("Maybe".send(method)).to eql(false)
        expect("i".send(method)).to eql(false)
        expect("I".send(method)).to eql(false)
        expect("i don't know".send(method)).to eql(false)
        expect("I DON'T KNOW".send(method)).to eql(false)
        expect("I don't know".send(method)).to eql(false)
      end
    end
  end

  [ :parse_bool!, :to_b! ].each do |method|
    describe "##{method}" do
      it "should return true if the string starts with 1, y, Y, t, or T" do
        expect("y".send(method)).to eql(true)
        expect("Y".send(method)).to eql(true)
        expect("yes".send(method)).to eql(true)
        expect("YES".send(method)).to eql(true)
        expect("Yes".send(method)).to eql(true)
        expect("t".send(method)).to eql(true)
        expect("T".send(method)).to eql(true)
        expect("true".send(method)).to eql(true)
        expect("TRUE".send(method)).to eql(true)
        expect("True".send(method)).to eql(true)
        expect("1".send(method)).to eql(true)
      end

      it "should return false if the string starts with 0, n, N, f, or F" do
        expect("n".send(method)).to eql(false)
        expect("N".send(method)).to eql(false)
        expect("no".send(method)).to eql(false)
        expect("NO".send(method)).to eql(false)
        expect("No".send(method)).to eql(false)
        expect("f".send(method)).to eql(false)
        expect("F".send(method)).to eql(false)
        expect("false".send(method)).to eql(false)
        expect("FALSE".send(method)).to eql(false)
        expect("False".send(method)).to eql(false)
        expect("0".send(method)).to eql(false)
      end

      it "should raise ArgumentError otherwise" do
        expect { "m".send(method) }.to raise_error(ArgumentError)
        expect { "maybe".send(method) }.to raise_error(ArgumentError)
        expect { "MAYBE".send(method) }.to raise_error(ArgumentError)
        expect { "Maybe".send(method) }.to raise_error(ArgumentError)
        expect { "i".send(method) }.to raise_error(ArgumentError)
        expect { "I".send(method) }.to raise_error(ArgumentError)
        expect { "i don't know".send(method) }.to raise_error(ArgumentError)
        expect { "I DON'T KNOW".send(method) }.to raise_error(ArgumentError)
        expect { "I don't know".send(method) }.to raise_error(ArgumentError)
        expect { "".send(method) }.to raise_error(ArgumentError)
      end
    end
  end
end

describe Kernel do
  describe "#Boolean" do
    it "should call String#parse_bool! and return the result" do
      string = double('String')
      result = double('result')

      expect(string).to receive(:parse_bool!).once.and_return(result)

      expect(Boolean(string)).to eql(result)
    end
  end
end
