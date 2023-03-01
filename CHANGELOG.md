# DeepNest

## 0.1.0

### Initial Release

  - Add recursive methods
    - deep_dup(obj) that returns a deep copy of the passed object
    - deep_merge(hash1, hash2, &block) that returns a hash with the passed hashes recursively merged. An optional block can be passed to merge values.
    - deep_equal?(obj1, obj2) that returns true if the passed objects are the same object, false otherwise.
    - deep_transform_keys(hash, &block) that returns a hash with its keys modified by the passed block.
    - deep_transform_values(hash, &block) that returns a hash with its values modified by the passed block.
    - deep_stringify_keys(hash) that returns a hash with its keys converted to strings.
    - deep_stringify_values(hash) that returns a hash with its values converted to strings.
  