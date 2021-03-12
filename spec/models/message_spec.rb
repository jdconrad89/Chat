require 'rails_helper'
require Rails.root.join('app/models/message.rb')

describe Message do
  context 'associations' do
    it { is_expected. to belong_to(:sender).class_name('User') }
    it { is_expected. to belong_to(:recipient).class_name('User') }
  end

  context 'class_methods' do
    describe '#create_message' do
      it 'should create a new message' do
        message_params = { sender: 'Tony Stark', recipient: 'Peter Parker', text: 'How do you like the new suit?' }

        message = Message.create_message(message_params)

        expect(message.text).to eq(message_params[:text])
      end
    end
  end
end
