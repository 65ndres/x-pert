# config/initializers/x.rb

require 'x'

# Load X API credentials from environment variables for security
x_credentials = {
  api_key:             ENV['X_API_KEY_2'],
  api_key_secret:      ENV['X_API_KEY_SECRET_2'],
  access_token:        ENV['X_ACCESS_TOKEN_2'],
  access_token_secret: ENV['X_ACCESS_TOKEN_SECRET_2'],
  # bearer_token: ENV['X_BEARER_TOKEN']
}

# Validate that all required credentials are present
missing_credentials = x_credentials.select { |key, value| value.nil? || value.empty? }
unless missing_credentials.empty?
  Rails.logger.error "Missing X API credentials: #{missing_credentials.keys.join(', ')}"
  raise "X API configuration incomplete. Please set #{missing_credentials.keys.join(', ')} in environment variables."
end

# Initialize the X API client with credentials
X_CLIENT = X::Client.new(**x_credentials)

# Optionally initialize an API v1.1 client if needed
X_CLIENT_V1 = X::Client.new(base_url: 'https://api.twitter.com/1.1/', **x_credentials)

# X_CLIENT_V1 = X::Client.new(base_url: 'https://api.twitter.com/1.1/', **x_credentials)

# Define a custom response struct for language data (as per example)
Language = Struct.new(:code, :name, :local_name, :status, :debug)

# Optional: Log successful initialization
Rails.logger.info 'X API client initialized successfully'

# Example usage (commented out to avoid execution during initialization)
=begin
# Get data about the authenticated user
user_data = X_CLIENT.get('users/me')
Rails.logger.info "Authenticated user: #{user_data['data']}"

# Post a tweet
post = X_CLIENT.post('tweets', '{"text":"Hello, World! (from Rails @gem)"}')
Rails.logger.info "Posted tweet: #{post['data']['id']}"

# Delete the tweet
X_CLIENT.delete("tweets/#{post['data']['id']}")
Rails.logger.info 'Tweet deleted successfully'
=end


# def get_likes(id)
#   require 'uri'
# require 'net/http'

# url = URI("https://api.x.com/2/trends/by/woeid/#{id}")

# http = Net::HTTP.new(url.host, url.port)
# http.use_ssl = true

# request = Net::HTTP::Get.new(url)
# request["Authorization"] = "Bearer #{ENV['X_BEARER_TOKEN']}"
# request["consumer_key"] = ENV["X_API_KEY"]
# request["consumer_secret"] = ENV["X_API_KEY_SECRET"]
# request["access_token"] = ENV["X_ACCESS_TOKEN"]
# request["token_secret"] = ENV["X_ACCESS_TOKEN_SECRET"]



# response = http.request(request)
# puts response.read_body
# end

# response for liked_tweets

# X_CLIENT.get('users/3264621318/liked_tweets?max_results=10')


# {"data"=>
#   [{"text"=>
#      "I really try to avoid politics on here because you don’t follow me for my 2 cents on goverment.\n\nSo I’ll leave it at this.\n\nI’m a proud Irish citizen. I love Irish people and Ireland. What has happened in the UK and Ireland enrages and disgusts me. It take a lot of will power not https://t.co/nZnL3CGzI4",
#     "id"=>"1961537726609817694",
#     "edit_history_tweet_ids"=>["1961537022159679751", "1961537726609817694"]},
#    {"text"=>"@renckorzay Cool thread but wasn't expecting to get a shill at the end",
#     "id"=>"1961521447639060754",
#     "edit_history_tweet_ids"=>["1961521447639060754"]},
#    {"text"=>"Dave Smith is Right, Israel Destroyed Israel https://t.co/LP1yZsriUE",
#     "id"=>"1961413534354469035",
#     "edit_history_tweet_ids"=>["1961413534354469035"]},
#    {"text"=>
#      "This guy goes on a rant why robots should not look like humans and I think he’s correct https://t.co/1dYPBHzf8s",
#     "id"=>"1961152935309525340",
#     "edit_history_tweet_ids"=>["1961152935309525340"]},
#    {"text"=>
#      "“Dragon Ball”:\nporque hicieron versiones humanas de los personajes de Dragon Ball y así se verían en carne y hueso https://t.co/oYSMhSurzE",
#     "id"=>"1961611075398557925",
#     "edit_history_tweet_ids"=>["1961611075398557925"]},
#    {"text"=>
#      "Man is saved by rescuers within 30 seconds after crashing his plane off the coast of Oak Island Pier in North Carolina.\n \nDrone footage captured rescuers rushing to pull the man out of his submerged plane after the crash. \n\nAccording to investigators, the plane experienced an https://t.co/tkQXnzGwQd",
#     "id"=>"1961589439882498302",
#     "edit_history_tweet_ids"=>["1961589439882498302"]},
#    {"text"=>
#      "💸 Another record yapping revenue this month!\n\n$7,870 ad rev share\n$2,683 X subs revenue\n(=$10,553 per 28 days)\n\n= $11,496/month\n\nPassed the record of May this year\n\n@X payouts are very nice 😊👍 https://t.co/EPgf6aBjgb https://t.co/ChtOzJBcSM",
#     "id"=>"1961611241908044048",
#     "edit_history_tweet_ids"=>["1961611241908044048"]},


# # export X_BEARER_TOKEN="AAAAAAAAAAAAAAAAAAAAAKSetQEAAAAArqf4T2mfyC0d7kRiOr8EM%2FyQdvw%3DxUqFBf5qpZlHR9frCIIT7lDOqdn2SLGBMAEuKoCT7GnMxydedd"


# response for own or others timeline
# X_CLIENT.get('users/3264621318/tweets?max_results=10')
# {"data"=>
#   [{"id"=>"1955706680756277422",
#     "edit_history_tweet_ids"=>["1955706680756277422"],
#     "text"=>"@emilysavesusa Another clown taking the trip haha"},
#    {"id"=>"1945172429543772606",
#     "edit_history_tweet_ids"=>["1945172429543772606"],
#     "text"=>"@charliekirk11 You got the call huh ?"},
#    {"id"=>"1937978274078191919",
#     "edit_history_tweet_ids"=>["1937978274078191919"],
#     "text"=>"@marklevinshow You’re what’s wrong with the world"},
#    {"id"=>"1937511462928359876",
#     "edit_history_tweet_ids"=>["1937511462928359876"],
#     "text"=>"@marklevinshow Levin is pure trash"},
#    {"id"=>"1936057703278727381",
#     "edit_history_tweet_ids"=>["1936057703278727381"],
#     "text"=>"@MarkSim57408932 @LexitMovement1 Payaso!"},
#    {"id"=>"1935019163912720755",
#     "edit_history_tweet_ids"=>["1935019163912720755"],
#     "text"=>"@realDonaldTrump What a disappointment you turned out to be …."},
#    {"id"=>"1934998601882534101",
#     "edit_history_tweet_ids"=>["1934998601882534101"],
#     "text"=>"@DineshDSouza @TradFidiGuy @ComicDaveSmith Getting rationed hard you warmonger haha"},


#     WOEID = 2459115

#     X_CLIENT.get("trends/by/woeid/#{WOEID}")
   