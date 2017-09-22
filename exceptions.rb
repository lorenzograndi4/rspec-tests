class RetryException < RuntimeError
  attr :ok_to_retry
  def initialize(ok_to_retry)
    @okToRetry = ok_to_retry
  end
end

# Somewhere down in the depths of the code, a transient error occurs.

# Higher up the call stack, we handle the exception.

begin
  stuff = readData(socket)
  # .. process stuff
rescue RetryException => detail
  retry if detail.ok_to_retry
  raise
end
