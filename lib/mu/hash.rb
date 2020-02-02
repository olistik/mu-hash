require 'mu/hash/version'

module Mu
  class Hash
    class Error < StandardError; end

    attr_accessor :value

    def initialize(value = {})
      self.value = value
    end

    def method_missing(key)
      super unless is_a_dictionary?

      stringified_key = key.to_s
      unless value.keys.include?(stringified_key)
        raise Error.new("Key #{stringified_key} doesn't exist at the current path.")
      end

      new_value = value[stringified_key]

      # returning the wrapped sub hash to allow nested chaining
      wrap(new_value)
    end

    def each
      return super unless value.kind_of?(Array)

      value.each do |item|
        yield wrap(item)
      end
    end

    def map
      return super unless value.kind_of?(Array)

      value.map do |item|
        yield wrap(item)
      end
    end

    def has_key?(key)
      return false unless is_a_dictionary?

      stringified_key = key.to_s
      value.keys.include?(stringified_key)
    end

    def [](key)
      if value.kind_of?(Array) && key.kind_of?(Numeric)
        if key >= value.length
          raise Error.new("Can't access index #{key} on a list of #{value.length} items.")
        end

        new_value = value[key]
        wrap(new_value)
      else
        self.send(key)
      end
    end

    def unwrap
      self.value
    end

    private

    def wrap(item)
      self.class.new(item)
    end

    def is_a_dictionary?
      return false unless value.respond_to?(:keys)
      value.keys.respond_to?(:include?)
    end
  end
end
