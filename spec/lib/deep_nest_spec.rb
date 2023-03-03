# frozen_string_literal: true

RSpec.describe 'DeepNest' do
  describe '::deep_dup(structure)' do
    subject { DeepNest.deep_dup(original) }

    describe 'when original structure is a scalar' do
      let(:original) { 'hello' }

      it 'returns the same value' do
        is_expected.to eq(original)
      end

      it 'allows changing of the copy without changing the original' do
        copy = subject
        copy += '!'

        expect(copy).to_not eq(original)
      end
    end

    describe 'when original structure is a simple array' do
      let(:original) { %w[a b c d] }

      it 'returns the same value' do
        is_expected.to eq(original)
      end

      it 'allows changing of the copy without changing the original' do
        copy = subject
        copy[0] = 'turtles'

        expect(copy).to_not eq(original)
      end
    end

    describe 'when original structure is a simple hash' do
      let(:original) { { a: 'a', b: 'b', c: 'd' } }

      it 'returns the same value' do
        is_expected.to eq(original)
      end

      it 'allows changing of the copy without changing the original' do
        copy = subject
        copy[:a] = 'turtles'

        expect(copy).to_not eq(original)
      end
    end

    describe 'when original structure is an array of arrays' do
      let(:original) { [%w[a b c], %w[d e f], %w[g h i]] }

      it 'returns the same value' do
        is_expected.to eq(original)
      end

      it 'allows changing of the copy without changing the original' do
        copy = subject
        copy[0][0] = 'turtles'

        expect(copy).to_not eq(original)
      end
    end

    describe 'when original structure is a hash of hashes' do
      let(:original) { { a: { a: 'a' }, b: { b: 'b' }, c: { c: 'c' } } }

      it 'returns the same value' do
        is_expected.to eq(original)
      end

      it 'allows changing of the copy without changing the original' do
        copy = subject
        copy[:a][:a] = 'turtles'

        expect(copy).to_not eq(original)
      end
    end

    describe 'when original structure is deeply nested' do
      let(:original) { { a: { b: { c: { d: [{ e: 'e' }] } } } } }

      it 'returns the same value' do
        is_expected.to eq(original)
      end

      it 'allows changing of the copy without changing the original' do
        copy = subject
        copy[:a][:b][:c][:d][0][:e] = 'turtles'

        expect(copy).to_not eq(original)
      end
    end
  end

  describe '::deep_merge(hash1, hash2, &block)' do
    describe 'if no block given' do
      subject { DeepNest.deep_merge(h1, h2) }

      describe 'with two simple hashes passed' do
        let(:h1) { { a: 100, b: 200 } }
        let(:h2) { { b: 300, c: 400 } }
        let(:expected_results) { { a: 100, b: 300, c: 400 } }

        it 'returns expected results' do
          is_expected.to eq(expected_results)
          is_expected.to eq(h1.merge(h2))
        end
      end

      describe 'with nested hashes with same keys in passed hashes' do
        let(:h1) { { a: true, b: { c: [1, 2, 3] } } }
        let(:h2) { { a: false, b: { c: [3, 4, 5] } } }
        let(:expected_results) { { a: false, b: { c: [3, 4, 5] } } }

        it 'returns expected results' do
          is_expected.to eq(expected_results)
          is_expected.to eq(h1.merge(h2))
        end
      end

      describe 'with nested hashes with different keys in passed hashes' do
        let(:h1) { { a: true, b: { c: [1, 2, 3] } } }
        let(:h2) { { a: false, b: { x: [3, 4, 5] } } }
        let(:expected_results) { { a: false, b: { c: [1, 2, 3], x: [3, 4, 5] } } }

        it 'returns expected results' do
          is_expected.to eq(expected_results)
        end
      end

      describe 'with deeply nested hashes in passed hashes' do
        let(:h1) { { a: true, b: { c: [1, 2, 3], d: { e: %w[foo bar], f: 'hello' } } } }
        let(:h2) { { a: false, b: { c: [3, 4, 5], d: { e: %w[bar baz] }, g: 'hi' } } }
        let(:expected_results) { { a: false, b: { c: [3, 4, 5], d: { e: %w[bar baz], f: 'hello' }, g: 'hi' } } }

        it 'returns expected results' do
          is_expected.to eq(expected_results)
        end
      end
    end

    describe 'if block given' do
      subject { DeepNest.deep_merge(h1, h2) { |_, v1, v2| v1 + v2 } }

      describe 'with two simple hashes passed' do
        let(:h1) { { a: 100, b: 200 } }
        let(:h2) { { b: 300, c: 400 } }
        let(:expected_results) { { a: 100, b: 500, c: 400 } }

        it 'returns expected results' do
          is_expected.to eq(expected_results)
        end
      end

      describe 'with nested hashes in passed hashes' do
        let(:h1) { { a: 100, b: 200, c: { d: 100, e: 10 } } }
        let(:h2) { { b: 300, c: { d: 300, f: 20 } } }
        let(:expected_results) { { a: 100, b: 500, c: { d: 400, e: 10, f: 20 } } }

        it 'returns expected results' do
          is_expected.to eq(expected_results)
        end
      end

      describe 'with deeply nested hashes in passed hashes' do
        let(:h1) { { a: 100, b: 200, c: { d: { e: 50, f: 20 } } } }
        let(:h2) { { b: 300, c: { d: { e: 10, g: 30 } } } }
        let(:expected_results) { { a: 100, b: 500, c: { d: { e: 60, f: 20, g: 30 } } } }

        it 'returns expected results' do
          is_expected.to eq(expected_results)
        end
      end
    end
  end

  describe '::deep_equal?(structure1, structure2)' do
    subject { DeepNest.deep_equal?(obj1, obj2) }

    describe 'when parameters are scalar' do
      describe 'with parameters that are the same' do
        let(:obj1) { 1 }
        let(:obj2) { 1 }

        it 'returns true' do
          is_expected.to be_truthy
        end
      end

      describe 'with integer and float that are same value' do
        let(:obj1) { 1 }
        let(:obj2) { 1.0 }

        it 'returns false' do
          is_expected.to be_falsy
        end
      end

      describe 'with integer and string that are same value' do
        let(:obj1) { 1 }
        let(:obj2) { '1' }

        it 'returns false' do
          is_expected.to be_falsy
        end
      end
    end

    describe 'when parameters are arrays' do
      describe 'with simple arrays have same values and order' do
        let(:obj1) { [1, 'hi', 2.0, true] }
        let(:obj2) { [1, 'hi', 2.0, true] }

        it 'returns true' do
          is_expected.to be_truthy
        end
      end

      describe 'with simple arrays have same values but different order' do
        let(:obj1) { [1, 'hi', 2.0, true] }
        let(:obj2) { [1, 'hi', true, 2.0] }

        it 'returns false' do
          is_expected.to be_falsy
        end
      end

      describe 'with simple arrays that is a subset of another' do
        let(:obj1) { [1, 'hi', 2.0, true] }
        let(:obj2) { [1, 'hi', 2.0] }

        it 'returns false' do
          is_expected.to be_falsy
        end
      end

      describe 'with matching arrays that have arrays' do
        let(:obj1) { [%w[a b c], %w[d e f], %w[g h i]] }
        let(:obj2) { [%w[a b c], %w[d e f], %w[g h i]] }

        it 'returns true' do
          is_expected.to be_truthy
        end
      end

      describe 'with differing arrays that have arrays' do
        let(:obj1) { [%w[a b c], %w[d e f], %w[g h i]] }
        let(:obj2) { [%w[a b c], %w[d e f], %w[j k l]] }

        it 'returns false' do
          is_expected.to be_falsy
        end
      end

      describe 'with matching arrays that have deeply nested arrays' do
        let(:obj1) { [1, [2, [3, 4, [5, 6, [7]]], 8], 9] }
        let(:obj2) { [1, [2, [3, 4, [5, 6, [7]]], 8], 9] }

        it 'returns true' do
          is_expected.to be_truthy
        end
      end

      describe 'with differing arrays that have deeply nested arrays' do
        let(:obj1) { [1, [2, [3, 4, [5, 6, [7]]], 8], 9] }
        let(:obj2) { [1, [2, [3, 4, [5, 6, [7, [10]]]], 8], 9] }

        it 'returns false' do
          is_expected.to be_falsy
        end
      end

      describe 'with matching arrays that have simple hashes' do
        let(:obj1) { [1, 'hi', 2.0, true, { a: 1, b: 2 }] }
        let(:obj2) { [1, 'hi', 2.0, true, { a: 1, b: 2 }] }

        it 'returns true' do
          is_expected.to be_truthy
        end
      end

      describe 'with differing arrays that have simple hashes' do
        let(:obj1) { [1, 'hi', 2.0, true, { a: 1, b: 2 }] }
        let(:obj2) { [1, 'hi', 2.0, true, { a: 1, b: '2' }] }

        it 'returns false' do
          is_expected.to be_falsy
        end
      end

      describe 'with matching arrays that have deeply nested hashes' do
        let(:obj1) { [1, 'hi', 2.0, true, hi: [{ a: { b: { c: { d: [{ e: 1 }] } } } }]] }
        let(:obj2) { [1, 'hi', 2.0, true, hi: [{ a: { b: { c: { d: [{ e: 1 }] } } } }]] }

        it 'returns true' do
          is_expected.to be_truthy
        end
      end

      describe 'with differing arrays that have deeply nested hashes' do
        let(:obj1) { [1, 'hi', 2.0, true, hi: [{ a: { b: { c: { d: [{ e: 1 }] } } } }]] }
        let(:obj2) { [1, 'hi', 2.0, true, hi: [{ a: { b: { c: { d: [{ e: 1.0 }] } } } }]] }

        it 'returns false' do
          is_expected.to be_falsy
        end
      end
    end

    describe 'when parameters are hashes' do
      describe 'with simple hashes with same key-value pairs and order' do
        let(:obj1) { { a: 1, b: 'string', c: true, d: 2.2, e: [1, 'a', true, 3.3] } }
        let(:obj2) { { a: 1, b: 'string', c: true, d: 2.2, e: [1, 'a', true, 3.3] } }

        it 'returns true' do
          is_expected.to be_truthy
        end
      end

      describe 'with simple hashes with same keys but different values' do
        let(:obj1) { { a: 1, b: 'string', c: true, d: 2.2 } }
        let(:obj2) { { a: 1, b: 'string', c: false, d: 2.2 } }

        it 'returns false' do
          is_expected.to be_falsy
        end
      end

      describe 'with simple hashes with same values but different keys' do
        let(:obj1) { { a: 1, b: 'string', c: true, d: 2.2 } }
        let(:obj2) { { a: 1, b: 'string', 'c': true, e: 2.2 } }

        it 'returns false' do
          is_expected.to be_falsy
        end
      end

      describe 'with simple hashes with same key-value pairs but in different order' do
        let(:obj1) { { a: 1, b: 'string', c: true, d: 2.2 } }
        let(:obj2) { { a: 1, b: 'string', d: 2.2, c: true } }

        it 'returns false' do
          is_expected.to be_falsy
        end
      end

      describe 'with one hash that is a subset of another' do
        let(:obj1) { { a: 1, b: 'string', c: true, d: 2.2 } }
        let(:obj2) { { a: 1, b: 'string', c: true } }

        it 'returns false' do
          is_expected.to be_falsy
        end
      end

      describe 'with matching hashes with hashes' do
        let(:obj1) { { a: { a: 'a' }, b: { b: 'b' }, c: { c: 'c' } } }
        let(:obj2) { { a: { a: 'a' }, b: { b: 'b' }, c: { c: 'c' } } }

        it 'returns true' do
          is_expected.to be_truthy
        end
      end

      describe 'with differing hashes with hashes' do
        let(:obj1) { { a: { a: 'a' }, b: { b: 'b' }, c: { c: 'c' } } }
        let(:obj2) { { a: { a: 'a' }, b: { b: 'b' }, c: { c: 'C' } } }

        it 'returns false' do
          is_expected.to be_falsy
        end
      end

      describe 'with matching hashes with deeply nested hashes' do
        let(:obj1) { { a: { b: [{ c: { d: [{ e: 1 }] } }] } } }
        let(:obj2) { { a: { b: [{ c: { d: [{ e: 1 }] } }] } } }

        it 'returns true' do
          is_expected.to be_truthy
        end
      end

      describe 'with differing hashes deeply nested hashes' do
        let(:obj1) { { a: { b: [{ c: { d: [{ e: 1.0 }] } }] } } }
        let(:obj2) { { a: { b: [{ c: { d: [{ e: 1 }] } }] } } }

        it 'returns false' do
          is_expected.to be_falsy
        end
      end
    end

    describe 'when parameters are hash and array' do
      let(:obj1) { { a: 1, b: 2, c: 3 } }
      let(:obj2) { [1, 2, 3] }

      it 'returns false' do
        is_expected.to be_falsy
      end
    end
  end

  describe '::deep_transform_keys(structure, &block)' do
    describe 'with passed simple hash and block' do
      subject { DeepNest.deep_transform_keys(hash) { |key| key.to_s.upcase } }

      let(:hash) { { str: 'String', num: 27 } }
      let(:expected_results) { { 'STR' => 'String', 'NUM' => 27 } }

      it 'returns expected results' do
        is_expected.to eq(expected_results)
        is_expected.to eq(hash.transform_keys { |k| k.to_s.upcase })
      end
    end

    describe 'with nested hash in passed hash' do
      subject { DeepNest.deep_transform_keys(hash) { |key| key.to_s.upcase } }

      let(:hash) { { a: 1, ['b', 1.0] => { a: %w[foo bar], b: 'hello' } } }
      let(:expected_results) { { 'A' => 1, '["B", 1.0]' => { 'A' => %w[foo bar], 'B' => 'hello' } } }

      it 'returns expected results' do
        is_expected.to eq(expected_results)
      end
    end

    describe 'with passed hash in old syntax' do
      subject { DeepNest.deep_transform_keys(hash) { |key| key.to_s.upcase } }

      let(:hash) { { :font_size => 10, :font_family => 'Arial' } }
      let(:expected_results) { { 'FONT_SIZE' => 10, 'FONT_FAMILY' => 'Arial' } }

      it 'returns expected results' do
        is_expected.to eq(expected_results)
        is_expected.to eq(hash.transform_keys { |k| k.to_s.upcase })
      end
    end

    describe 'with passed block in alternative format' do
      subject { DeepNest.deep_transform_keys(hash, &:to_sym) }

      let(:hash) { { 'a': 1, 'b': 2, 'c': 3 } }
      let(:expected_results) { { a: 1, b: 2, c: 3 } }

      it 'returns expected results' do
        is_expected.to eq(expected_results)
        is_expected.to eq(hash.transform_keys(&:to_sym))
      end
    end

    describe 'with hash in passed array' do
      subject { DeepNest.deep_transform_keys(array) { |key| key.to_s.upcase } }

      let(:array) { [1, 'a', 2.0, { hello: 1.0 }] }
      let(:expected_results) { [1, 'a', 2.0, { 'HELLO' => 1.0 }] }

      it 'returns array' do
        is_expected.to eq(expected_results)
      end
    end

    describe 'with passed object that is not a hash or array' do
      subject { DeepNest.deep_transform_keys(obj) { |key| key.to_s.upcase } }

      let(:obj) { 'hello' }

      it 'returns object' do
        is_expected.to eq(obj)
      end
    end
  end

  describe '::deep_transform_values(structure, &block)' do
    describe 'with passed simple hash and block' do
      subject { DeepNest.deep_transform_values(hash) { |value| value.to_s.upcase } }

      let(:hash) { { str: 'String', int: 27, float: 1.0, bool: true } }
      let(:expected_results) { { str: 'STRING', int: '27', float: '1.0', bool: 'TRUE' } }

      it 'returns expected results' do
        is_expected.to eq(expected_results)
        is_expected.to eq(hash.transform_values { |v| v.to_s.upcase })
      end
    end

    describe 'with nested hash in passed hash' do
      subject { DeepNest.deep_transform_values(hash) { |value| value.to_s.upcase } }

      let(:hash) { { a: 1, [1, 2] => { a: %w[foo bar], b: [1, 'hello'] } } }
      let(:expected_results) { { a: '1', [1, 2] => { a: %w[FOO BAR], b: %w[1 HELLO] } } }

      it 'returns expected results' do
        is_expected.to eq(expected_results)
      end
    end

    describe 'with passed hash in old syntax' do
      subject { DeepNest.deep_transform_values(hash) { |value| value.to_s.upcase } }

      let(:hash) { { :font_size => 10, :font_family => 'Arial' } }
      let(:expected_results) { { font_size: '10', font_family: 'ARIAL' } }

      it 'returns expected results' do
        is_expected.to eq(expected_results)
        is_expected.to eq(hash.transform_values { |v| v.to_s.upcase })
      end
    end

    describe 'with passed block in alternative format' do
      subject { DeepNest.deep_transform_values(hash, &:to_f) }

      let(:hash) { { a: 1, b: 2, c: 3 } }
      let(:expected_results) { { a: 1.0, b: 2.0, c: 3.0 } }

      it 'returns expected results' do
        is_expected.to eq(expected_results)
        is_expected.to eq(hash.transform_values(&:to_f))
      end
    end

    describe 'with passed array with hash' do
      subject { DeepNest.deep_transform_values(array) { |value| value.to_s.upcase } }

      let(:array) { [1, 'hello', 2.0, { a: 'hello', b: 1.0 }] }
      let(:expected_results) { ['1', 'HELLO', '2.0', { a: 'HELLO', b: '1.0' }] }

      it 'returns array with hash that has transformed values' do
        is_expected.to eq(expected_results)
      end
    end

    describe 'with passed object that is not a hash or array' do
      subject { DeepNest.deep_transform_values(obj) { |value| value.to_s.upcase } }

      let(:obj) { 'hello' }
      let(:expected_results) { 'HELLO' }

      it 'returns object' do
        is_expected.to eq(expected_results)
      end
    end
  end

  describe '::deep_stringify_keys(structure)' do
    subject { DeepNest.deep_stringify_keys(structure) }

    describe 'with passed simple hash' do
      let(:structure) { { str: 'String', int: 27, float: 1.0, bool: true } }
      let(:expected_results) { { 'str' => 'String', 'int' => 27, 'float' => 1.0, 'bool' => true } }

      it 'returns expected results' do
        is_expected.to eq(expected_results)
        is_expected.to eq(structure.transform_keys(&:to_s))
      end
    end

    describe 'with nested hash in passed hash' do
      let(:structure) { { a: 1, ['b', 1.0] => { a: %w[foo bar], b: 'hello' } } }
      let(:expected_results) { { 'a' => 1, '["b", 1.0]' => { 'a' => %w[foo bar], 'b' => 'hello' } } }

      it 'returns expected results' do
        is_expected.to eq(expected_results)
      end
    end

    describe 'with passed hash in old syntax' do
      let(:structure) { { :font_size => 10, :font_family => 'Arial' } }
      let(:expected_results) { { 'font_size' => 10, 'font_family' => 'Arial' } }

      it 'returns expected results' do
        is_expected.to eq(expected_results)
        is_expected.to eq(structure.transform_keys(&:to_s))
      end
    end

    describe 'with hash in passed array' do
      let(:structure) { [1, 'a', 2.0, { a: 1 }] }
      let(:expected_results) { [1, 'a', 2.0, { 'a' => 1 }] }

      it 'returns array with hash that has stringified key' do
        is_expected.to eq(expected_results)
      end
    end

    describe 'with passed object that is not a hash or array' do
      let(:structure) { 'hello' }

      it 'returns object' do
        is_expected.to eq(structure)
      end
    end
  end

  describe '::deep_symbolize_keys(structure)' do
    subject { DeepNest.deep_symbolize_keys(structure) }

    describe 'with passed simple hash' do
      let(:structure) { { 'str': 'String', 'int': 27, 'float': 1.0, 'bool': true } }
      let(:expected_results) { { str: 'String', int: 27, float: 1.0, bool: true } }

      it 'returns expected results' do
        is_expected.to eq(expected_results)
        is_expected.to eq(structure.transform_keys(&:to_sym))
      end
    end

    describe 'with nested hash in passed hash' do
      let(:structure) { { 'a': 1, '["b", 1.0]': { 'a': %w[foo bar], 'b': 'hello' } } }
      let(:expected_results) { { a: 1, "[\"b\", 1.0]": { a: %w[foo bar], b: 'hello' } } }

      it 'returns expected results' do
        is_expected.to eq(expected_results)
      end
    end

    describe 'with hash in passed array' do
      let(:structure) { [1, 'a', 2.0, { 'a': 1 }] }
      let(:expected_results) { [1, 'a', 2.0, { a: 1 }] }

      it 'returns array with hash that has symbolized key' do
        is_expected.to eq(expected_results)
      end
    end

    describe 'with passed object that is not a hash or array' do
      let(:structure) { 'hello' }

      it 'returns object' do
        is_expected.to eq(structure)
      end
    end
  end
end
