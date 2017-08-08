require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @good_user = User.create({
      first_name: 'George',
      last_name: 'Vargess',
      email: 'george@nothing.com',
      password: '123456789',
      password_confirmation: '123456789'
    })
    @empty_user = User.create
end

  describe '#new' do

    it 'should create a new user if all fields exist' do
      expect(@good_user).to be_valid
    end

    it 'should have both a password and password confirmation' do
      expect(@empty_user.errors.full_messages).to include("Password can't be blank" || "Password confirmation can't be blank")
    end

    it 'should have matching password and password_conformation' do
      @mismatched_pass_user = User.create({
        first_name: 'George',
        last_name: 'Vargess',
        email: 'george@nothing.com',
        password: '123456789',
        password_confirmation: '987654321'
      })
      expect(@mismatched_pass_user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should create a password digest if all fields exist' do
      expect(@good_user.password_digest).to be_truthy
    end

    it 'should check to see if the email already exists' do
      @another_good_user_same_email = User.create({
        first_name: 'Another',
        last_name: 'Guy',
        email: 'george@nothing.com',
        password: '123456789',
        password_confirmation: '123456789'
      })

      @same_email_dif_case = User.create({
        first_name: 'Another',
        last_name: 'Guy',
        email: 'GEORGE@nothing.com',
        password: '123456789',
        password_confirmation: '123456789'
      })

      expect(@another_good_user_same_email.errors.full_messages).to include ("Email has already been taken")
      expect(@same_email_dif_case.errors.full_messages).to include ("Email has already been taken")

    end


    it 'should have a minimum password length' do
      @short_pass = User.create({
        first_name: 'George',
        last_name: 'Vargess',
        email: 'newguy@thing.com',
        password: '12345',
        password_confirmation: '12345'
      })
      expect(@short_pass.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end

  end
end