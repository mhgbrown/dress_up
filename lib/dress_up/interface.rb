module DressUp
  # The Interface module provides the methods to
  # define, put on, and take off costumes.
  module Interface
    def self.included(base)
      base.send :extend, ClassMethods
      base.send :include, InstanceMethods
    end

    module ClassMethods
      # When extedended, define closet reader
      def self.extended(base)
        class << base
          attr_reader :closet
        end
        base.instance_variable_set("@closet", {})
      end

      # Define a costume by giving it a name and a set of overrides
      def costume(name, overrides={})
        unless name.is_a?(Symbol) || name.is_a?(String)
          raise "#{name.inspect} is not a valid costume name"
        end

        @closet ||= {}
        if overrides.empty?
          @closet[name]
        else
          @closet[name] = DressUp::Costume.new(name, overrides)
        end
      end
    end

    module InstanceMethods
      # When included, define the outfit reader
      def self.included(base)
        base.class_eval do
          attr_reader :outfit
        end
      end

      # Apply the costume with the given name to this object and
      # set up and outfit if necessary.  If the  costume does not exist,
      # an error is raised.
      def put_on(costume_name)
        costume = self.class.closet[costume_name]
        if costume
          @outfit ||= DressUp::Outfit.new(self)
          @outfit.apply(costume)
          costume
        else
          raise DressUp::Errors::UndefinedCostumeError, costume_name
        end
      end

      # Apply all the costumes defined for this object's class.  Set up an
      # oufit if necessary.
      def dress_up
        @outfit ||= DressUp::Outfit.new(self)
        @outfit.apply(*self.class.closet.values)
      end

      # Remove the costume with the given name from this object and clear an
      # existing outfit if necessary.  If the costume does not exist, an
      # error is raised.
      def take_off(costume_name)
        costume = self.class.closet[costume_name]
        if costume
          @outfit && @outfit.remove(costume)
          @outfit = nil if @outfit && @outfit.empty?
        else
          raise DressUp::Errors::UndefinedCostumeError, costume_name
        end
      end

      # Remove all the costumes defined for this object's class.  Clear an
      # existing outfit if necessary.
      def dress_down
        @outfit && @outfit.remove(*self.class.closet.values)
        @outfit = nil if @outfit && @outfit.empty?
      end
    end
  end
end