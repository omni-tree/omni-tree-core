# Develop

## Return Mutable Instances as Immutable

OmniTree requires the ability to create a mutable instance, modify it, but return it as an
immutable instance. In C++, it is possible to do this by using `const` in the return type. There
is no such mechanism in Swift.

In object-oriented languages that don't support `const` like C++, one approach is to define
interfaces with getters only, making instances of that interface immutable. The implementation
of the interface is made to contains setters as well, making instances of the implementation
mutable. This allows a mutable instance to be created and modified, but returned as an
immutable instance by using the interface as the return type.

We use the above immutable-interface/mutable-implementation approach with Swift in
OmniTree. [Swift does not yet support covariance in protocol implementations] [1], so the
implementation of this approach is not as clean as it could be.

[1]: https://bugs.swift.org/browse/SR-522
