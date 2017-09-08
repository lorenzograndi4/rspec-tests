::learnings::

. Run tests adding --format documentation

. There are many ways to rescue errors in your code. Not all of them make sense.

. Importing data from an external source makes the initial method NOT a pure function.

. Although, splitting the methods will enable us to test in an easier way.

. Tests will help you write better code!

. Tests will help you understand how to shape your code and make it more robust.

. You can pass either a block or an argument to your expectation
and they will behave differently!

. Calling split will always return an array, so not interesting to test.

. Net::HTTP and RestClient seem to return different things, both different from regular HTTP requests

. Catching timeouts is frustrating

. You can test using assertions about input, and expectations about output

. Test the interface, not the implementation (it would bind you to the current implementation)

. Never rescue from exception, rescue from StandardError

. When functions are pure and values are easy to inspect and create,
then every function call can be reproduced in isolation.
