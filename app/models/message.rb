class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User', foreign_key: "sender_id"
  belongs_to :recipient, class_name: 'User', foreign_key: "recipient_id"


  def self.create_message(message_params)
    sender_id = message_user(message_params[:sender])
    recipient_id = message_user(message_params[:recipient])

    Message.create(sender_id: sender_id, recipient_id: recipient_id, text: message_params[:text])
  end

  def self.message_user(username)
    User.generator(username).id
  end
end
