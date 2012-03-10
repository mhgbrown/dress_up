module DressUp
  module Interface
    def self.included(base)
      base.send :extend, ClassMethods
    end

    module ClassMethods
      def costume(name, overrides={})
      end
    end
  end
end