Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post "/send_message" => "messages#send_message"
      get "/recent_communication_from_user" => "messages#recent_communication_from_user"
      get "recent_messages" => "messages#recent_messages"
    end
  end
end
