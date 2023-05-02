# DeepNest

## 0.1.2

### Downgrade Required Ruby version

  - Downgraded required Ruby version from 2.7.2 to 2.6.3

## 0.1.1

### Include DeepNest in native Ruby classes

  - Add helper namespace to use self in recursive methods (i.e. can use `structure.deep_dup` instead of `DeepNest.deep_dup(structure)`).
  - Add patch file to allow users to monkey patch recursive methods in native Hash and Array Ruby classes.
  - Add patch spec.

## 0.1.0

### Initial Release

  - Add recursive methods
    - deep_dup(structure) that returns a deep copy of the passed hash or array.
    - deep_merge(hash1, hash2, &block) that returns a hash with the passed hashes recursively merged. An optional block can be passed to merge values.
    - deep_equal?(struct1, struct2) that returns true if the passed objects are same in structure and values, false otherwise.
    - deep_transform_keys(structure, &block) that returns a hash or array with all hash keys modified by the passed block.
    - deep_transform_values(structure, &block) that returns a hash or array with all hash values modified by the passed block.
    - deep_stringify_keys(structure) that returns hash or array with all hash keys converted to strings.
    - deep_stringify_values(structure) that returns a hash or array with all hash keys converted to symbols.
  