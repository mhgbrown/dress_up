require 'spec_helper'

describe DressUp do

  before(:all) do

    class Duck
      include DressUp::Interface

      attr_accessor :name, :age

      def initialize(name, age)
        @name, @age = name, age
      end

      def speak
        "Quack!"
      end

      def youngsters
        [Duck.new("John", 0.5), Duck.new("Julia", 0.5)]
      end
    end

  end

  it "should provide a method to declare a costume" do
    Duck.respond_to?(:costume).should == true
  end

  it "should allow the specification of return values from a particular method" do
  end

  it "should allow the specification of multiple costumes" do
  end

  it "should replace an old costume with a new costume of the same name" do
  end

  it "should provide a way to put on a costume" do
  end

  it "should provide a way to take off a costume" do
  end

  describe "when a costume is already on" do

    # or should this somehow merge the return values?
    it "any new costume that is put on should override the current costume's return values where they overlap" do
    end

    it "and then when the costume is taken off, the object's method should return what they originally did" do
    end

  end

  it "should provide a way to access all the costumes that are on in the order that they were put on" do
  end

  it "should provide a way to take off all costumes" do
  end

end