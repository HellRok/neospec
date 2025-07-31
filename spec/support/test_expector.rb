class TestExpector
  include Neospec::Expector::EqualityExpectors
  include Neospec::Expector::ErrorExpectors
  include Neospec::Expector::InclusionExpectors

  attr_accessor :success, :failure

  def initialize(actual:)
    @actual = actual
    @success = nil
    @failure = nil
  end

  def actual
    if @actual.is_a?(Proc)
      @actual = @actual.call
    end

    @actual
  end

  def succeeded(message)
    @success = message
  end

  def failed(message)
    @failure = message
  end
end
