class Leaderboard

  # def self.key
  #   "leaderboard"
  # end

  def self.get_user_score(key, user)
    Redis.current.ZSCORE(key, user.display_name)
  end

  def self.get_user_rank(key, user)
    rank = Redis.current.ZREVRANK(key, user.display_name)
    return unless rank
    rank + 1
  end

  def self.del_key(key)
    Redis.current.DEL(key)
  end

  def self.remove_user(key, user)
    Redis.current.ZREM(key, user.display_name)
  end

  def self.award_points_to_user(key, user, points)
    Redis.current.ZINCRBY(key, points, user.display_name)
  end

  def self.get_keys_begin_with(text)
    Redis.current.keys("#{text}*")
  end

  def self.top(key, limit = -1)
    top = Redis.current.zrevrange(key, 0, limit, :withscores => true)
    leaders = []
    top.each_with_index do |e, i|
      leaders << {display_name: e[0], score: e[1].to_i, rank: i + 1}
    end

    leaders
  end

end
