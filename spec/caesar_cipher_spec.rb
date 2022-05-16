require './caesar_cipher'

describe Cipher do
  describe '#caesar_cipher' do
    it 'returns the correct lowercase cipher' do
      cipher = Cipher.new
      expect(cipher.caesar_cipher('abc', 2)).to eql('cde')
    end

    it 'returns the correct uppercase cipher' do
      cipher = Cipher.new
      expect(cipher.caesar_cipher('ABC', 2)).to eql('CDE')
    end

    it 'returns the correct uppercase+lowercase cipher' do
      cipher = Cipher.new
      expect(cipher.caesar_cipher('AbC', 2)).to eql('CdE')
    end

    it 'handles overflow' do
      cipher = Cipher.new
      expect(cipher.caesar_cipher('xyz', 2)).to eql('zab')
    end
  end
end