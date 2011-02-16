# Mixin module that adds no features, but simply includes a @Boolean@ type in
# the parent class's heirarchy. This allows you to do things like:
#
# <pre><code>
#   if variable.kind_of?(Boolean) then
#     [ ... ]
#   end
# </code></pre>

module Boolean; end

class TrueClass
  include Boolean

  # Returns the _typecasted_ value of this object.
  #
  # @return [true] @true@.
  def to_bool() true end

  # Returns the _parsed_ value of this object.
  #
  # @return [true] @true@.
  def parse_bool() true end
  
  # @see #parse_bool
  def to_b() true end
end

class FalseClass
  include Boolean

  # Returns the _typecasted_ value of this object.
  #
  # @return [false] @false@.
  def to_bool() false end

  # Returns the _parsed_ value of this object.
  #
  # @return [false] @false@.
  def parse_bool() false end
  
  # @see #parse_bool
  def to_b() false end
end

class NilClass
  # Returns the _typecasted_ value of this object.
  #
  # @return [false] @false@.
  def to_bool() false end

  # Returns the _parsed_ value of this object.
  #
  # @return [false] @false@.
  def parse_bool() false end

  # @see #parse_bool
  def to_b() false end
end

class Object
  # Returns the _typecasted_ value of this object. This would be @true@ for all
  # objects except @false@ and @nil@, which type-cast to @false@.
  #
  # @return [true, false] The typecast value of this object.
  def to_bool() true end
end

class String
  # Returns the _parsed_ value of this object. Strings beginning with any of
  # "y", "t", or "1" are considered @true@, whereas all else are considered
  # @false@.
  #
  # @return [true, false] The parsed Boolean value of this string.
  # @see #parse_bool!
  def parse_bool() %w( y Y 1 t T ).include? self[0] end

  # @see #parse_bool
  def to_b() parse_bool end

  # Similar to {#parse_bool}, but raises an error unless the string can be
  # explicitly parsed to @true@ or @false@. Strings beginning with "n", "f", or
  # "0" are considered false.
  #
  # @return [true, false] The parsed Boolean value of this string.
  # @raise [ArgumentError] If the string does not seem to represent @true@ or
  #   @false@.
  # @example
  #   "true".parse_bool! #=> true
  #   "no".parse_bool! #=> false
  #   "maybe".parse_bool! #=> ArgumentError
  def parse_bool!
    if %w( y Y 1 t T ).include? self[0] then
      true
    elsif %w( n N 0 f F ).include? self[0] then
      false
    else
      raise ArgumentError, "Invalid value for parse_bool!: #{inspect}"
    end
  end

  # @see #parse_bool!
  def to_b!() parse_bool! end
end

module Kernel
  # @see String#parse_bool!
  def Boolean(string)
      string.parse_bool!
  rescue ArgumentError => err
    raise ArgumentError, err.message.gsub('parse_bool!', 'Boolean()')
  end
end

class Numeric
  # Returns the _parsed_ value of this object. Numbers equal to zero are
  # considered @false@; all others are considered @true@.
  #
  # @return [true, false] The parsed Boolean value of this number.
  def parse_bool() not zero? end

  # @see #parse_bool
  def to_b() not zero? end
end
