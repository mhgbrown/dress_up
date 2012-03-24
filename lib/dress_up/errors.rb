module DressUp
  # Errors holds DressUp specific errors.
  module Errors

    # UndefinedCostumeError is raised when an operation
    # is performed with a costume that has not been defined.
    class UndefinedCostumeError < StandardError

      # The default error message highlights the absence
      # of the costume
      def initialize(costume)
        super("#{costume} has not been defined")
      end
    end
  end
end