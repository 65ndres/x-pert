class User < ApplicationRecord
  has_many :posts


  def create_suggetions
    # new timline (last 5)
    # new liked (last 5)
    # +
    # old timeline all (maybe last 25) ? 
    # old liked (maybe last 25)
    # +
    # inspiration
    # = variables needed to pass to script
  end

  def create_suggestion_script(liked, timeline, inspiration)
    script = "
      Youre an expert content creator with an especialization on the X platform.
      based on: the LIKED posts, on the TIMELINE
      and the INSPIRATION craft 10 possible post and 10 possible replies 
      Here are the LIKED posts:
      #{liked}
      Here are the TIMELINE posts:
      #{timeline} and 
      Here are the INSPIRATION posts:
      #{inspiration}
    "
  end
end
