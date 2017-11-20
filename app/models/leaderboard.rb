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

  def self.get_departments
    Redis.current.SMEMBERS(:departments)
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

  def self.admin_statistics(quiz_id, limit = -1)
    top = Redis.current.zrevrange("statistics:quiz:#{quiz_id}", 0, limit, :withscores => true)
    statistics = []
    top.each_with_index do |e, i|
      user_id = e[0].sub("user:", "").to_i
      user = User.find(user_id)
      display_name = user.display_name
      real_name = user.profile.real_name
      department = user.profile.department

      Redis.current.SADD(:departments, department) if department != ""

      score = Redis.current.ZSCORE("score:quiz:#{quiz_id}", "user:#{user_id}")
      right = Redis.current.ZSCORE("right:quiz:#{quiz_id}", "user:#{user_id}")
      wrong = Redis.current.ZSCORE("wrong:quiz:#{quiz_id}", "user:#{user_id}")

      statistics << {display_name: display_name, answered: e[1].to_i, rank: i + 1, user_id: user_id,
                  real_name: real_name, department: department, score: score,
                  right: right, wrong: wrong }
    end

    statistics
  end


end
