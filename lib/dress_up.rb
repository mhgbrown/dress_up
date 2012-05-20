require "dress_up/version"
require "dress_up/interface"
require "dress_up/costume"
require "dress_up/outfit"
require "dress_up/errors"

module DressUp

  # include DressUp::Interface if DressUp
  # is included
  def self.included(base)
    base.send :include, DressUp::Interface
  end

end
