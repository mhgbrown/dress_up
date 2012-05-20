# Dress Up [![Build Status](https://secure.travis-ci.org/mhgbrown/dress_up.png)](http://travis-ci.org/mhgbrown/dress_up)
Let's play dress-up! Dress Up allows you to specify named sets of method overrides that you can selectively enable and disable.  It makes for a sort of an on-the-fly decorator pattern.

## Compatibility
Dress Up relies on the Ruby 1.9.X ordering of Hash entries.

## Example
Below is the Duck class that has defined two costumes: dog and robosoldier.  The dog costume overrides the ```name=``` method to append "Dog" and the ```speak``` method to return "Woof!".  The robosoldier costume overrides ```speak``` as well and adds a new method, ```terminations```.

	class Duck
		# include the Dress Up functionality
		include DressUp

		attr_accessor :name, :age

		# define a dog costume
		costume :dog, :name= => lambda {|name| @name = name + " Dog"}, :speak => "Woof!"
		# define a robosoldier costume
		costume :robosoldier, :speak => lambda {"I will terminate you! " + super()}, :terminations => 23

		def initialize(name, age)
			@name, @age = name, age
		end

		def speak
			"Quack!"
		end
	end

When the dog costume is applied, it overrides the methods it specifies:

	duck = Duck.new("Horace", 2)
	duck.put_on(:dog)
	duck.name = "George"
	puts duck.name
	=> "George Dog"
	puts duck.speak
	=> "Woof!"

When the robosoldier costume is applied, its overrides are merged with dog's overrides and reapplied.

	duck.put_on(:robosoldier)
	puts duck.speak
	=> "I will terminate you! Quack!"
	puts duck.terminations
	=> 23

When the dog and robosoldier costumes are removed, their overrides are removed.

	duck.take_off(:dog)
	duck.name = "T1000"
	puts duck.name
	=> "T1000"
	duck.take_off(:robosoldier)
	puts duck.speak
	=> "Quack!"
	puts duck.terminations
	=> NoMethodError

All the costumes can be applied at once:

	duck.dress_up
	duck.name = "Bob"
	puts duck.name
	=> "Bob Dog"
	puts duck.terminations
	=> 23

They can also all be removed at once:

	duck.dress_down
	puts duck.speak
	=> "Quack!"

Access all of Duck's costumes:

	Duck.closet
	=> {:dog => <DressUp::Costume ... >, ...}

Access a duck's current outfit:

	duck.put_on(:dog)
	duck.outfit
	=> <DressUp::Outfit ... >

## Future Considerations
 * Instead of merging overrides, just define overrides in sequence


