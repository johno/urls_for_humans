require 'urls_for_humans/version'

require 'active_support/concern'
require 'active_support/inflector'
require 'active_support/core_ext/object/blank'

module UrlsForHumans
  extend ActiveSupport::Concern

  module ClassMethods
    attr_accessor :humanly_attrs

    def urls_for_humans(*humanly_attrs)
      @humanly_attrs = humanly_attrs
    end
  end

  def to_param
    (self.class.humanly_attrs || humanly_attrs).dup.unshift(:id).map do |attrib|
      send(attrib).to_s.parameterize
    end.reject(&:blank?).join('-')
  end
end
