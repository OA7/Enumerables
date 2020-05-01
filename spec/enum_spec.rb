require '../enum.rb'

RSpec.describe Enumerable do
  let(:array1) { [0, 1, 2, 3, 4, 5, 6, 7, 8, 9] }
  let(:array2) { ['hello', 'hey', 'hi', 'holla', 'yea', 'good'] }
  let(:array3) { [1, 2, 3, 4] }
  let(:array4) { [2, 4, 6, 8] }
  let(:array5) { [2, 4, 6, 8, 'jersey', %w[why me cr7 oa7]] }
  let(:new_array) {[]}

  describe '#my_each' do

    it 'Passes each element to a new array based on some operation' do
      array1.my_each { |ele| new_array << ele * 1}

      expect(new_array).to eql(array1)
    end

    it 'Returns a new array based on some arguments passed' do
      array1.my_each { |ele| new_array << ele if ele.even? && ele > 0 }

      expect(new_array).to eql(array4)
    end

    it 'Returns the Enumerator when no block is given' do
      expect(array1.my_each).to be_kind_of(Enumerator)
    end

  end

  describe '#my_each_with_index' do

    it 'Returns the Enumerator when no block is given' do
      expect(array1.my_each_with_index).to be_kind_of(Enumerator)
    end

    it 'Returns element plus index when argument is passed' do
      array3.my_each_with_index { |ele, index| new_array << "#{index} : #{ele}"}

      expect(new_array).to eql(["0 : 1", "1 : 2", "2 : 3", "3 : 4"])
    end

    it 'Return the index position and element when specific results are wanted' do
      array3.my_each_with_index { |ele, index| new_array << "#{index} : #{ele}" if ele.even? }

      expect(new_array).to eql([ "1 : 2", "3 : 4"])
    end

  end

  describe '#my_select' do

    it 'Returns specific data from the array based on the argument passed' do
      array2.my_select { |ele| new_array << ele if ele.include?('h') }
      expect(new_array).to eq(['hello', 'hey', 'hi', 'holla'])
    end

    it 'Returns new array with specific data based on arguments' do 
      array1.my_select { |ele| new_array << ele if ele.odd? && ele > 0 }

      expect(new_array). to eq([1, 3, 5, 7, 9])
    end

    it 'Returns the Enumerator when no block is given' do
      expect(array1.my_select).to be_kind_of(Enumerator)
    end

  end

  describe '#my_all?' do
    
    it "Returns false when all elements of the array don\'t\ have an \'h'\ in them" do
      expect(array2.my_all?(/[h]/)).to be false
    end

    it 'Returns true if all elements of the array contain vowels(aeiou)' do
      expect(array2.my_all?(/[aeiou]/)).to be true
    end

    it 'Returns false if all elements of the array are not Integers' do
      expect(array5.my_all?(Integer)).to be false
    end
  end

  describe '#my_any?' do

    it "Returns false when none of the elements in the array contains a \'t'\ " do
      expect(array2.my_any?(/[z]/)).to be false
    end

    it "Returns true if any of the elements in the array contains the string \'ello'\ " do
      expect(array2.my_any? { |ele| ele.include?('ello')} ).to be true
    end

    it 'Returns true if any of the elements is an Array' do
      expect(array5.my_any?(Array)).to be true
    end

  end
end