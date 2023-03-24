# frozen_string_literal: true

RSpec.describe 'DeepNest::Patch' do
  methods = %i[deep_dup deep_merge deep_equal? deep_transform_keys deep_transform_values deep_stringify_keys
               deep_symbolize_keys]

  describe 'Array instance methods' do
    it 'includes methods in native Array class' do
      methods.each do |deep_nest_method|
        expect(Array.instance_methods).to include(deep_nest_method)
      end
    end
  end

  describe 'Hash instance methods' do
    it 'includes methods in native Hash class' do
      methods.each do |deep_nest_method|
        expect(Hash.instance_methods).to include(deep_nest_method)
      end
    end
  end
end
