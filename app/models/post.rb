class Post < ApplicationRecord
  validates :text, presence: true
  validates :x_id, presence: true

  belongs_to :user

  enum post_type: { draft: 0, authored: 1, loved: 2, liked: 3 }

  def self.pull_own_timeline
    user = User.last

    response = X_CLIENT.get("users/#{user.x_user_id}/tweets?max_results=5")
    puts response
    # {"data"=>
    #   [{"id"=>"1955706680756277422",
    #     "edit_history_tweet_ids"=>["1955706680756277422"],
    #     "text"=>"@emilysavesusa Another clown taking the trip haha"}]}

    own_posts = response["data"]
    
    own_posts.each do |lp|
      Post.create!(text: lp["text"], x_id: lp["id"], user_id: user.id, post_type: 1)
    end
  end


  def self.pull_lastest_liked
    user = User.last
    response = X_CLIENT.get("users/#{user.x_user_id}/liked_tweets?max_results=5")
    # puts response
    # # response = {"data"=>
    # #   [{"text"=>
    # #      "I really try to avoid politics on here because you don't follow me for my 2 cents on goverment.\n\nSo I'll leave it at this.\n\nI'm a proud Irish citizen. I love Irish people and Ireland. What has happened in the UK and Ireland enrages and disgusts me. It take a lot of will power not https://t.co/nZnL3CGzI4",
    # #     "id"=>"1961537726609817694",
    # #     "edit_history_tweet_ids"=>["1961537022159679751", "1961537726609817694"]},
    # #    {"text"=>"@renckorzay Cool thread but wasn't expecting to get a shill at the end",
    # #     "id"=>"1961521447639060754",
    # #     "edit_history_tweet_ids"=>["1961521447639060754"]}]}


  # response =  {"data"=>
  # [{"text"=>
  #    "I really try to avoid politics on here because you don’t follow me for my 2 cents on goverment.\n\nSo I’ll leave it at this.\n\nI’m a proud Irish citizen. I love Irish people and Ireland. What has happened in the UK and Ireland enrages and disgusts me. It take a lot of will power not https://t.co/nZnL3CGzI4",
  #   "id"=>"1961537726609817694",
  #   "edit_history_tweet_ids"=>["1961537022159679751", "1961537726609817694"]},
  #  {"text"=>"@renckorzay Cool thread but wasn't expecting to get a shill at the end",
  #   "id"=>"1961521447639060754",
  #   "edit_history_tweet_ids"=>["1961521447639060754"]},
  #  {"text"=>"Dave Smith is Right, Israel Destroyed Israel https://t.co/LP1yZsriUE",
  #   "id"=>"1961413534354469035",
  #   "edit_history_tweet_ids"=>["1961413534354469035"]},
  #  {"text"=>
  #    "This guy goes on a rant why robots should not look like humans and I think he’s correct https://t.co/1dYPBHzf8s",
  #   "id"=>"1961152935309525340",
  #   "edit_history_tweet_ids"=>["1961152935309525340"]},
  #  {"text"=>
  #    "“Dragon Ball”:\nporque hicieron versiones humanas de los personajes de Dragon Ball y así se verían en carne y hueso https://t.co/oYSMhSurzE",
  #   "id"=>"1961611075398557925",
  #   "edit_history_tweet_ids"=>["1961611075398557925"]},
  #  {"text"=>
  #    "Man is saved by rescuers within 30 seconds after crashing his plane off the coast of Oak Island Pier in North Carolina.\n \nDrone footage captured rescuers rushing to pull the man out of his submerged plane after the crash. \n\nAccording to investigators, the plane experienced an https://t.co/tkQXnzGwQd",
  #   "id"=>"1961589439882498302",
  #   "edit_history_tweet_ids"=>["1961589439882498302"]},
  #  {"text"=>
  #    "💸 Another record yapping revenue this month!\n\n$7,870 ad rev share\n$2,683 X subs revenue\n(=$10,553 per 28 days)\n\n= $11,496/month\n\nPassed the record of May this year\n\n@X payouts are very nice 😊👍 https://t.co/EPgf6aBjgb https://t.co/ChtOzJBcSM",
  #   "id"=>"1961611241908044048",
  #   "edit_history_tweet_ids"=>["1961611241908044048"]}]}

    liked_posts = response["data"]

    liked_posts.each do |lp|
      Post.create!(text: lp["text"], x_id: lp["id"], user_id: user.id, post_type: 3)
    end
  end
end
