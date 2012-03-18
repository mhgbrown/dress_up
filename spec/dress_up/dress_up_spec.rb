require 'spec_helper'

describe DressUp do

  before(:each) do

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

  after(:each) do
    Object.send(:remove_const, :Duck)
  end

  let(:duck) { Duck.new("Horace", 5) }

  it "should provide a method to declare a costume" do
    Duck.respond_to?(:costume).should == true
  end

  it "should raise an error if a costume is declared without a name" do
    lambda { Duck.costume(:speak => "Woof!") }.should raise_error
  end

  describe "when a costume has been declared" do
    before(:each) do
      Duck.costume(:dog, :speak => "Woof!", :name= => lambda {|value| @name = value + " Dog"})
    end

    it "should provide a method to get that costume" do
      Duck.costume(:dog).should == "?"
    end

    it "should provide a method to put on a costume, which will override the specified costume methods to return the specified values" do
      duck.put_on(:dog)
      duck.speak.should == "Woof!"
      duck.name = "Fluffy"
      duck.name.should == "Fluffy Dog"
    end

    it "should return a costume when your put on a costume" do
      duck.put_on(:dog).class.should == DressUp::Costume
    end

    it "should provide raise an error when you try to put on a costume that doesn't exist" do
      lambda { duck.put_on(:cow) }.should raise_error(DressUp::UndefinedCostumeError)
    end

    it "should provide a way to take off a costume" do
      duck.put_on(:dog)
      duck.take_off(:dog)
      duck.speak.should == "Quack!"
    end

    it "should return nothing if you try to take off a costume that is not on" do
      duck.take_off(:dog).should == nil
    end

    it "should raise an error if you try to take off a costume that does not exist" do
      lambda { duck.take_off(:cow) }.should raise_error(DressUp::UndefinedCostumeError)
    end

    it "should create a method supplied by the costume when it does not exist on the target object" do
      Duck.costume(:robosoldier, :kills => 57)
      duck.put_on(:robosoldier)
      duck.kills.should == 57
    end

    it "should allow the specification of multiple costumes" do
    end

    it "should provide a method to get all the costumes" do
      duck.closet.should == "?"
    end

    it "should replace an old costume with a new costume of the same name" do
      Duck.costume(:dog, :speak => "Bark!")
      duck.speak.should == "Bark!"
      duck.name = "Jeffrey"
      duck.name.should == "Jeffrey"
    end
  end

  # what happens if you redefined a costume before it has been taken off?

  describe "when a costume is already on" do

    before(:each) do
      Duck.costume(:dog, :speak => "Woof!", :name= => lambda {|value| @name = value + " Dog"})
      Duck.costume(:robosoldier, :speak => "You will be terminated!", :kills => 57)
      duck.put_on(:dog)
    end

    # or should this somehow merge the return values?
    it "any new costume that is put on should override the current costume's return values where they overlap" do
      duck.put_on(:robosoldier)
      duck.speak.should == "You will be terminated!"
      duck.name = "T2600"
      duck.name.should == "T2600 Dog"
      duck.kills.should == 57
    end

    it "and then when the costume is taken off, the object's method should return what they originally did" do
      duck.put_on(:robosoldier)
      duck.take_off(:robosoldier)
      duck.speak.should == "Woof!"
      duck.respond_to?(:kills).should == false
    end

  end

  it "should provide a way to access all the costumes that are on in the order that they were put on" do
    duck.outfit.should == "?" # some sort of outfit (set of costumes)
  end

  it "should provde a way to put on all the costumes" do
    duck.dress_up
    # test for the intersection of all costumes!
  end

  it "should provide a way to take off all costumes" do
    duck.dress_down
    # test for no costume modifications!
  end

end