require 'urls_for_humans/version'

require 'active_support/inflector'
require 'active_support/core_ext/object/blank'

module UrlsForHumans
  def self.extended(model_class)
    return if model_class.respond_to?(:urls_for_humans)

    model_class.class_eval do
      class << self
        attr_accessor :humanly_attrs
      end

      extend Base
      include Model
    end
  end

  module Base
    def urls_for_humans(*humanly_attrs)
      @humanly_attrs = humanly_attrs
    end
  end

  module Model
    def to_param
      self.class.humanly_attrs.dup.unshift(:id).map do |attrib|
        ActiveSupport::Inflector.parameterize(send(attrib).to_s)
      end.reject(&:blank?).join('-')
    end
  end
end
