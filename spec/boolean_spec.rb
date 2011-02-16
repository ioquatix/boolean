require 'spec_helper'

describe TrueClass do
  [ :to_bool, :parse_bool, :to_b ].each do |method|
    describe "##{method}" do
      it("should return true") { true.send(method).should eql(true) }
    end
  end

  it("should be a kind of Boolean") { true.should be_kind_of(Boolean) }
end

describe FalseClass do
  [ :to_bool, :parse_bool, :to_b ].each do |method|
    describe "##{method}" do
      it("should return false") { false.send(method).should eql(false) }
    end
  end

  it("should be a kind of Boolean") { false.should be_kind_of(Boolean) }
end

describe NilClass do
  [ :to_bool, :parse_bool, :to_b ].each do |method|
    describe "##{method}" do
      it("should return false") { nil.send(method).should eql(false) }
    end
  end
end

describe Object do
  describe "#to_bool" do
    it("should return true") { Object.new.to_bool.should eql(true) }
  end

  it("should not be a kind of Boolean") { Object.new.should_not be_kind_of(Boolean) }
end

describe Numeric do
  [ :parse_bool, :to_b ].each do |method|
    describe "##{method}" do
      it "should return true if the number is not zero" do
        1.send(method).should eql(true)
        1.0.send(method).should eql(true)
        -1.send(method).should eql(true)
        -1.0.send(method).should eql(true)
      end

      it "should return false if the number is zero" do
        0.send(method).should eql(false)
        0.0.send(method).should eql(false)
      end
    end
  end
end

describe String do
  [ :parse_bool, :to_b ].each do |method|
    describe "##{method}" do
      it "should return true if the string starts with 1, y, Y, t, or T" do
        "y".send(method).should eql(true)
        "Y".send(method).should eql(true)
        "yes".send(method).should eql(true)
        "YES".send(method).should eql(true)
        "Yes".send(method).should eql(true)
        "t".send(method).should eql(true)
        "T".send(method).should eql(true)
        "true".send(method).should eql(true)
        "TRUE".send(method).should eql(true)
        "True".send(method).should eql(true)
        "1".send(method).should eql(true)
      end

      it "should return false otherwise" do
        "n".send(method).should eql(false)
        "N".send(method).should eql(false)
        "no".send(method).should eql(false)
        "NO".send(method).should eql(false)
        "No".send(method).should eql(false)
        "f".send(method).should eql(false)
        "F".send(method).should eql(false)
        "false".send(method).should eql(false)
        "FALSE".send(method).should eql(false)
        "False".send(method).should eql(false)
        "0".send(method).should eql(false)

        "m".send(method).should eql(false)
        "maybe".send(method).should eql(false)
        "MAYBE".send(method).should eql(false)
        "Maybe".send(method).should eql(false)
        "i".send(method).should eql(false)
        "I".send(method).should eql(false)
        "i don't know".send(method).should eql(false)
        "I DON'T KNOW".send(method).should eql(false)
        "I don't know".send(method).should eql(false)
      end
    end
  end

  [ :parse_bool!, :to_b! ].each do |method|
    describe "##{method}" do
      it "should return true if the string starts with 1, y, Y, t, or T" do
        "y".send(method).should eql(true)
        "Y".send(method).should eql(true)
        "yes".send(method).should eql(true)
        "YES".send(method).should eql(true)
        "Yes".send(method).should eql(true)
        "t".send(method).should eql(true)
        "T".send(method).should eql(true)
        "true".send(method).should eql(true)
        "TRUE".send(method).should eql(true)
        "True".send(method).should eql(true)
        "1".send(method).should eql(true)
      end

      it "should return false if the string starts with 0, n, N, f, or F" do
        "n".send(method).should eql(false)
        "N".send(method).should eql(false)
        "no".send(method).should eql(false)
        "NO".send(method).should eql(false)
        "No".send(method).should eql(false)
        "f".send(method).should eql(false)
        "F".send(method).should eql(false)
        "false".send(method).should eql(false)
        "FALSE".send(method).should eql(false)
        "False".send(method).should eql(false)
        "0".send(method).should eql(false)
      end

      it "should raise ArgumentError otherwise" do
        -> { "m".send(method) }.should raise_error(ArgumentError)
        -> { "maybe".send(method) }.should raise_error(ArgumentError)
        -> { "MAYBE".send(method) }.should raise_error(ArgumentError)
        -> { "Maybe".send(method) }.should raise_error(ArgumentError)
        -> { "i".send(method) }.should raise_error(ArgumentError)
        -> { "I".send(method) }.should raise_error(ArgumentError)
        -> { "i don't know".send(method) }.should raise_error(ArgumentError)
        -> { "I DON'T KNOW".send(method) }.should raise_error(ArgumentError)
        -> { "I don't know".send(method) }.should raise_error(ArgumentError)
      end
    end
  end
end

describe Kernel do
  describe "#Boolean" do
    it "should call String#parse_bool! and return the result" do
      string = mock('String')
      result = mock('result')

      string.should_receive(:parse_bool!).once.and_return(result)

      Boolean(string).should eql(result)
    end
  end
end
