# frozen_string_literal: true

RSpec.describe 'DeepNest' do
  let(:klass) { DeepNest }

  it "is a module" do
    expect(klass).to be_a(Module)
  end
end
