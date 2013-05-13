require 'spec_helper'

describe TheDude::Http do
  describe '#initialize' do
    context 'when a url is passed' do
      it 'should start a visit to that url' do
       
      end
    end
  end

  describe '#url' do
    it 'should be nil' do
      TheDude::Http.new.url.should be_nil
    end

    context 'when a visit has been started' do
      before :each do
        @http = TheDude::Http.new
        @http.visit 'http://example.org'
      end

      it 'should be the current url' do
        @http.url.should == 'http://example.org'
      end
    end
  end

  describe '#source' do
    context 'when there is a current url' do
      before :each do
        @url = 'https://www.google.co.uk'
        @http = TheDude::Http.new @url
      end

      it 'should fetch the url and return the source' do
        #@http.source.should == WEBMOCKS[@url]
      end
    end
  end

  describe '#visit' do
    context 'when passed a url' do
      it 'should set the url property' do
      end
    end
  end
end
