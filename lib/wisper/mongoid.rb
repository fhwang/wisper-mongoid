require 'wisper/mongoid/version'
require 'wisper/mongoid/publisher'

# A micro library providing Ruby objects with Publish-Subscribe capabilities.
module Wisper
  def self.model
    ::Wisper::Mongoid::Publisher
  end

  # Integrates Wisper wih Mongoid.
  module Mongoid
    def self.extend_all
      ::Mongoid::Document.class_eval { include Wisper.model }
    end
  end
end
