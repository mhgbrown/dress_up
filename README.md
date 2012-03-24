# Dress Up [![Build Status](https://secure.travis-ci.org/mhgbrown/dress_up.png)](http://travis-ci.org/mhgbrown/dress_up)
Let's play dress-up! Dress Up allows you to specify named sets of method overrides that you can selectively enable and disable.

	Class Duck
		include DressUp::Interface
		attr_accessor :name, age

		costume :dog, :name= => lambda {|name| @name = name + " Dog"}, :speak => "Woof!"
		costume :robosoldier, :speak => "I will terminate you!", :terminations => 57

		def initialize(name, age)
			@name, @age = name, age
		end

		def speak
			"Quack!"
		end
	end

	>> duck = Duck.new("Horace", 2)
	>> duck.put_on(:dog)
	>> duck.name = "George"
	>> duck.name
	=> "George Dog"
	>> duck.speak
	=> "Woof!"
	>> duck.put_on(:robosoldier)
	>> duck.speak
	=> "I will terminate you!"
	>> duck.terminations
	=> 57
	>> duck.take_off(:dog)
	>> duck.name = "T1000"
	>> duck.name
	=> "T1000"

