# == Leaderboard Information
#
#  with Redis
#
#  Score: user scores
#  Score = right * 100 + wrong * 10
#  =================================
#  key            score:quiz:quiz_id
#  element        user:user_id
#
#  Statistics: User answered counts
#  Statistics
#  =================================
#  key            statistics:quiz:quiz_id
#  element        user:user_id
#
#  Right: User right answers count
#  =================================
#  key            right:quiz:quiz_id
#  element        user:user_id
#
#  Wrong: User wrong answers count
#  =================================
#  key            wrong:quiz:quiz_id
#  element        user:user_id
#

class Leaderboard

  def self.prefixs
    ["score", "statistics", "right", "wrong"]
  end

  def self.get_user_score(key, user)
    Redis.current.ZSCORE(key, "user:#{user.id}")
  end

  def self.get_user_rank(key, user)
    rank = Redis.current.ZREVRANK(key, "user:#{user.id}")
    return unless rank
    rank + 1
  end

  def self.del_key(key)
    Redis.current.DEL(key)
  end

  def self.remove_element(key, element)
    Redis.current.ZREM(key, element)
  end


  def self.award_points_to_user(key, element, points)
    Redis.current.ZINCRBY(key, points, element)
  end

  def self.get_keys_begin_with(text)
    Redis.current.keys("#{text}*")
  end

  def self.top(key, limit = -1)
    top = Redis.current.zrevrange(key, 0, limit, :withscores => true)
    leaders = []
    top.each_with_index do |e, i|
      user = User.find(e[0].sub("user:", "").to_i)
      display_name = user.display_name
      leaders << {display_name: display_name, score: e[1].to_i, rank: i + 1}
    end

    leaders
  end

end
