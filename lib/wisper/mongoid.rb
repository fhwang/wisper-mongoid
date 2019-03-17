require 'wisper/mongoid/version'
require 'wisper/mongoid/publisher'

module Wisper
  def self.model
    ::Wisper::Mongoid::Publisher
  end

  module Mongoid
    def self.extend_all
      ::Mongoid::Document.class_eval { include Wisper.model }
    end
  end
end
