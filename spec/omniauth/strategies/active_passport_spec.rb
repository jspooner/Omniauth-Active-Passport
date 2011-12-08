require 'spec_helper'

describe OmniAuth::Strategies::ActivePassport do
  def app; lambda{|env| [200, {}, ["Hello."]]} end
  let(:fresh_strategy){ Class.new(OmniAuth::Strategies::ActivePassport) }

  describe '#client' do
    subject{ fresh_strategy }

    it 'should be initialized with symbolized client_options' do
      instance = subject.new(app, :client_options => {'authorize_url' => 'https://example.com'})
      instance.client.options[:authorize_url].should == 'https://example.com'
    end
  end

  describe '#token_params' do
    subject { fresh_strategy }

    it 'should include parse => json as well as any authorize params passed in the :authorize_params option' do
      instance = subject.new('abc', 'def', :token_params => {:foo => 'bar', :baz => 'zip'})
      instance.token_params.should == {'foo' => 'bar', 'baz' => 'zip', 'parse' => :json}
    end

    it 'should include parse => json as well as any top-level options that are marked as :authorize_options' do
      instance = subject.new('abc', 'def', :token_options => [:scope, :foo], :scope => 'bar', :foo => 'baz')
      instance.token_params.should == {'scope' => 'bar', 'foo' => 'baz', 'parse' => :json}
    end
  end
end
