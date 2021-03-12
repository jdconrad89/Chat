require 'rails_helper'
require Rails.root.join('app/models/user.rb')

describe User do
  context 'validations' do
    it { is_expected.to validate_uniqueness_of :username }
    it { is_expected.to validate_presence_of :username }
  end

  context 'class_methods' do
    describe '#generator' do
      it 'should create or find an existing user when given a username' do
        username = "Tony Stark"

        user = User.generator(username)

        expect(user.username).to eq(username)
      end
    end
  end
end
