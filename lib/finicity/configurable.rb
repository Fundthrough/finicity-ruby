require "hashie"

module Finicity
  module Configurable
    KEYS = [:redis_url, :app_key, :partner_id, :partner_secret, :max_retries, :app_type, :verbose].freeze

    attr_writer(*KEYS)

    def configure
      yield self
      self
    end

    def configs
      @configs ||= begin
        hash = {}
        KEYS.each { |key| hash[key] = instance_variable_get(:"@#{key}") }
        Hashie::Mash.new(hash)
      end
    end
  end
end
