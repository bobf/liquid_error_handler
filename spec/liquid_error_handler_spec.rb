# frozen_string_literal: true

RSpec.describe LiquidErrorHandler do
  let(:template) { Liquid::Template.parse(content) }
  let(:content) { fixture('template.liquid').read }

  before(:all) { Liquid::Template.register_filter(TestFilters) }
  before(:each) { LiquidErrorHandler.reset }

  it 'has a version number' do
    expect(LiquidErrorHandler::VERSION).not_to be nil
  end

  it 'calls error handler when error occurs during render' do
    liquid_error = nil

    LiquidErrorHandler.register_handler do
      liquid_error = true
    end

    template.render

    expect(liquid_error).to_not be_nil
  end

  it 'passes raised error to handler block' do
    liquid_error = nil

    LiquidErrorHandler.register_handler do |error|
      liquid_error = error
    end

    template.render

    expect(liquid_error).to be_a ArgumentError
  end

  it 'calls multiple handlers' do
    liquid_error1 = nil
    liquid_error2 = nil

    LiquidErrorHandler.register_handler do
      liquid_error1 = 'error 1'
    end

    LiquidErrorHandler.register_handler do
      liquid_error2 = 'error 2'
    end

    template.render

    expect(liquid_error1).to eql 'error 1'
    expect(liquid_error2).to eql 'error 2'
  end

  it 'renders original content' do
    original = template.render

    LiquidErrorHandler.register_handler do |error|
      @error = error
    end

    expect(template.render).to eql original
  end

  context 'with LIQUID_ERROR_HANDLER_DISABLE present in environment' do
    before { stub_const('ENV', ENV.to_h.merge('LIQUID_ERROR_HANDLER_DISABLE' => '1')) }

    it 'does not execute handlers' do
      liquid_error = nil

      LiquidErrorHandler.register_handler do
        liquid_error = true
      end

      template.render

      expect(liquid_error).to be_nil
    end
  end
end
