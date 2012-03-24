module DressUp
  # Outfit represents a set of costumes in use by a given object.
  class Outfit

    attr_reader :costumes, :getup, :object

    # Create a new outfit with the given object.  Method overrides
    # provided by costumes associated with this outfit will
    # be applied to this object.
    def initialize(object)
      @costumes = {}
      @getup = {}
      @object = object
    end

    # Apply the given costumes to this outfit's object. Costume overrides
    # are applied in the order that costumes are put on.
    def apply(*other_costumes)
      change_getup do
        other_costumes.each do |costume|
          @costumes[costume.name] = costume.overrides
        end
      end
    end

    # Remove the given costumes from this outfit's object.
    def remove(*other_costumes)
      change_getup do
        other_costumes.each do |costume|
          @costumes.delete(costume.name)
        end
      end
    end

    # Determine if this outfit has no costumes.
    def empty?
      @costumes.empty?
    end

    private

    # Change the getup of this outfit safely by removing
    # all of the overrides, rebuilding the getup and finally
    # reapplying the overrides. Takes a block in which it is assumed
    # changes to the costumes will be made.
    def change_getup(&block)
      peel_down
      yield if block_given?
      rebuild
      suit_up
    end

    # Rebuild the final getup from all the active costumes.
    def rebuild
      @getup = @costumes.inject({}) do |hash, (name, overrides)|
        hash.merge!(overrides)
      end
    end

    # Apply the getup (overrides) to the object.
    def suit_up
      @getup.each do |method_name, callable|
        @object.send(:define_singleton_method, method_name, &callable)
      end
    end

    # Remove the overrides from the object.
    def peel_down
      @getup.each do |method_name, _|
        remove_singleton_method(method_name)
      end
    end

    # Remove a singleton method from the object.  Does not completely
    # undefine the method from the context.
    def remove_singleton_method(name)
      metaclass = @object.instance_eval "class << self; self; end"
      metaclass.send(:remove_method, name)
    end

  end
end