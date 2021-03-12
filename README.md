# Chat API 

The Chat Api allows you to send messages to other users. By simply inputting some information a message will be generated that a user can access.
At this time in order to access the api you will need to clone the repository locally and utilize curl commands in the command line tool of your choice (I personally use terminal which comes standard with any Mac).

Once you have cloned the repository and ran `bundle install` in your command line kick off the rails server with a `rails s` and the api will get running for you. In another terminal window we will now be able to communicate with the api for your messaging needs.

## Curl Commands

* If you wish to send someone a message use the curl command below and fill in your desired sender, recipient, and the message you wish to send, for instance:
   `curl -d 'sender=Tony Stark&recipient=Peter Parker&text=How do you like the new suit?'  localhost:3000/api/v1/send_message`
   will send a message to Peter Parker from Tony Stark.
   
* If you want to view messages sent to a user from a specific sender there are two options of how to return your results, you can view the last 100 messages sent, or you can view all the messages sent in the last 30 days. You will need to provide the name of the sender and the recipient as well as include which search type you prefer with a simple boolean. For example `curl -X GET "localhost:3000/api/v1/recent_communication_from_user?sender=Tony%20Stark&recipient=Peter%20Parker&in_the_last_30_days=true”` will return all messages sent to Peter Parker from Tony Stark in the past 30 days, where as `curl -X GET "localhost:3000/api/v1/recent_communication_from_user?sender=Tony%20Stark&recipient=Peter%20Parker&in_the_last_30_days=false"` will return the most recent 100 messages.

* You also have the ability to see recent messages sent from all messages with the same options for search results filtering (last 100 or within the last 30 days) with `curl -X GET  "localhost:3000/api/v1/recent_messages?in_the_last_30_days=true”` returning all messages within the last 30 days and `curl -X GET  "localhost:3000/api/v1/recent_messages?in_the_last_30_days=false”` returning the last 100 messages.


## Next Steps

From here I have a number of next steps for what I would do and what other features I would have added. 
* I first would've deployed out to heroku so that I could then create a small local rails app that would be able to communicate with the api. 
* I would also go back in and work further on formatting the returned json from the queries to make it easier for for other applications to work with.
* I would create a Conversation object that when called would returned all the messages sent between two or more users. 
* Assuming that eventually this would be used by any number of applications I would adjust the User model to account for the possibility of the same name being used from different peopoe on different apps and incorporate a unique id (probably utilizing uuid) so that people from different applications (or even the same application) would be able to have the same name without being able to see the conversations, sent messages, etc of another user.
