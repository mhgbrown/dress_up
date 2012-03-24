module DressUp
  # Costume represents a named set of method overrides.
  class Costume

    attr_reader :name, :overrides

    # Create a new costume with the given name and overrides.  Overrides are
    # converted into lambdas if necessary.
    def initialize(name, overrides={})
      @name = name
      @overrides = overrides.inject({}) do |hash, (method_name, value)|
        unless value.respond_to? :call
          hash[method_name] = lambda { value }
        else
          hash[method_name] = value
        end
        hash
      end
    end

    # Retreive an override with its identifier
    def [](override)
      @overrides[override]
    end

  end
end