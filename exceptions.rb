class RetryException < RuntimeError
  attr :ok_to_retry
  def initialize(ok_to_retry)
    @okToRetry = ok_to_retry
  end
end
