module Api
  module V1
    class MessagesController < ApplicationController
      skip_before_action :verify_authenticity_token

      def send_message
        @message = Message.create_message(message_params)
        if @message.save
          render json: {}, status: 200
        else
          render json: {}, status: 400
        end
      end

      def recent_communication_from_user
        if in_the_last_30_days_flag?
          @messages = communication_from_user_in_past_30_days
        else
          @messages = last_one_hundred_messages_from_user
        end

        render json: { messages: @messages }, status: 200
      end

      def recent_messages
        if in_the_last_30_days_flag?
          @messages = Message.where(created_at: 30.days.ago..)
        else
          @messages = Message.last(100)
        end

        render json: { messages: @messages }, status: 200
      end


      private

        def userid(user)
          User.find_by(username: user)
        end

        def communication_from_user_in_past_30_days
          Message.where(sender_id: userid(params[:sender]),
                        recipient_id: userid(params[:recipient]),
                        created_at: 30.day.ago..)
        end

        def last_one_hundred_messages_from_user
          Message.where(sender_id: userid(params[:sender]),
                        recipient_id: userid(params[:recipient])).limit(100)
        end

        def message_params
          params.permit(
            :sender,
            :recipient,
            :text
          )
        end

        def in_the_last_30_days_flag?
          params[:in_the_last_30_days]
        end
    end
  end
end
