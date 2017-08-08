require 'rails_helper'

RSpec.describe Product, type: :model do
  before :each do
    @category = Category.create name: 'Stuff'
    @product = @category.products.create name: 'Thing', price: 100, quantity: 1
    @badproduct = Product.create
  end

  describe '#new' do
    it 'should be valid' do
      expect(@product).to be_valid
    end

    it 'should have a name' do
      expect(@badproduct.errors.full_messages).to include("Name can't be blank")
    end

    it 'should have a price' do
      expect(@badproduct.errors.full_messages).to include("Price can't be blank")
      expect(@badproduct.errors.full_messages).to include("Price is not a number")
    end

    it 'should have a quantity' do
      expect(@badproduct.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should have a category' do
      expect(@badproduct.errors.full_messages).to include("Category can't be blank")
    end
  end
end
