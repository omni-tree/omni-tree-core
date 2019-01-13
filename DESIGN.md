# Design

## Return Mutable Instances as Immutable

OmniTree requires the ability to create a mutable instance, modify it, but return it as an
immutable instance. The [builder pattern][1] cannot be used since we need the ability to
continue mutating the instance.

In C++, it is possible to do this by using `const` in the return type. There is no such
mechanism in Swift.

Another approach is to define an interface with getters only, so instances of that interface will
be immutable. The implementation of the interface defines setters as well, so instances of the
implementation will be mutable. This allows a mutable instance to be created and modified,
but returned as an immutable instance by using the interface as the return type.

We use the above immutable-interface/mutable-implementation approach with Swift in
OmniTree. [Swift does not yet support covariance in protocol implementations][2], so the
implementation of this approach is not as clean as it could be.

[1]: https://en.wikipedia.org/wiki/Builder_pattern
[2]: https://bugs.swift.org/browse/SR-522
