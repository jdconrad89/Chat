require 'rails_helper'
require Rails.root.join('app/controllers/api/v1/messages_controller.rb')

module Api
  module V1
    describe MessagesController do

      describe '#send_message' do
        it 'should send a message when given the correct information' do
          params = { sender: 'Tony Stark', recipient: 'Peter Parker', text: 'How do you like the new suit?' }

          post "/api/v1/send_message", params: params, as: :json

          expect(response.status).to eq(200)
          expect(Message.last.text).to eq(params.dig(:message, :text))
        end

        it 'should not send a message when not given all of the information' do
          params = { sender: 'Tony Stark', text: 'How do you like the new suit?' }

          post "/api/v1/send_message", params: params, as: :json

          expect(response.status).to eq(400)
        end
      end

      describe '#recent_communication_from_user' do
        before(:each) do
          @sender = create(:user)
          @recipient = create(:user, username: "Peter Parker")
          create_list(:message, 200, sender: @sender, recipient: @recipient, )
        end

        it 'should return 100 recent messages from a given user when in_the_last_30_days is not selected' do
          params = { sender: "Tony Stark", recipient: "Peter Parker", in_the_last_30_days: false }

          get "/api/v1/recent_communication_from_user", params: params, as: :json

          expect(response.status).to eq(200)
          expect(response.body).to include(@recipient.id.to_s)
          expect(response.body.scan(/(?=sender_id)/).count).to eq(100)
        end

        it 'should return all messages from a given user within the last 30 days when specified' do
          create_list(:message, 100, sender: @sender, recipient: @recipient, created_at: DateTime.now - 40.days)
          params = { sender: "Tony Stark", recipient: "Peter Parker", in_the_last_30_days: true }

          get "/api/v1/recent_communication_from_user", params: params, as: :json

          expect(response.body.scan(/(?=sender_id)/).count).to eq(200)
        end
      end

      describe '#recent_messages' do
        before(:each) do
          @sender = create(:user)
          @recipient = create(:user, username: "Peter Parker")
          create_list(:message, 75, sender: @sender, recipient: @recipient, )
          create_list(:message, 75, sender: @recipient, recipient: @sender, )
        end

        it 'should return 100 total messages from users when in_the_last_30_days is not specified' do
          params = { in_the_last_30_days: false }

          get "/api/v1/recent_messages", params: params, as: :json

          expect(response.body.scan(/(?=sender_id)/).count).to eq(100)
          expect(response.body).to include("\"sender_id\":#{@sender_id}")
          expect(response.body).to include("\"sender_id\":#{@recipient_id}")
        end

        it 'should return messages from users within last 30 days when specified' do
          create_list(:message, 100, sender: @sender, recipient: @recipient, created_at: DateTime.now - 40.days)
          params = { in_the_last_30_days: true }

          get "/api/v1/recent_messages", params: params, as: :json

          expect(response.body.scan(/(?=sender_id)/).count).to eq(150)
          expect(response.body).to include("\"sender_id\":#{@sender_id}")
          expect(response.body).to include("\"sender_id\":#{@recipient_id}")
        end
      end
    end
  end
end
