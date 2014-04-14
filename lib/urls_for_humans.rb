require "urls_for_humans/version"
require "urls_for_humans/base"

module UrlsForHumans
  def self.extended(model_class)
    return if model_class.respond_to?(:urls_for_humans)

    model_class.class_eval do
      extend Base
      include Model
    end
  end

  module Model
    def humanly_attrs
      self.class.humanly_attrs
    end

    def to_param
      "#{ id }-#{ humanly_attrs.map(&:parameterize).join('-') }"
    end
  end
end
