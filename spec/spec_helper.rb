require 'rubygems'
require 'bundler/setup'
require 'rspec'

require 'urls_for_humans'

I18n.enforce_available_locales = false

RSpec.configure do |config|
  config.color_enabled = true
end

class User
  extend UrlsForHumans

  urls_for_humans :first_name, :last_name

  attr_accessor :first_name, :last_name

  def initialize(first_name, last_name)
    self.first_name = first_name
    self.last_name  = last_name
  end

  def id
    10
  end
end
