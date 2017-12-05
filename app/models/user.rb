class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :comments
  serialize :upvoted_comments
  serialize :downvoted_comments
  serialize :flagged_comments

  def create_or_fetch_mobile_token
    if !(token = read_attribute(:mobile_token))

      while self.class.exists?(mobile_token: token = SecureRandom.hex); end
      self.update_column(:mobile_token, token)
    end

    return token
  end

  def valid_mobile_token?(key)
    return (k = read_attribute(:mobile_token)) && key == k
  end

  def add_upvoted_comment(comment)
    if self.upvoted_comments.nil?
      self.upvoted_comments = [comment.id]
      self.save!
    else
      self.upvoted_comments.push(comment.id)
      self.save!
    end
  end

  def add_downvoted_comment(comment)
    if self.downvoted_comments.nil?
      self.downvoted_comments = [comment.id]
      self.save!
    else
      self.downvoted_comments.push(comment.id)
      self.save!
    end
  end

  def remove_upvoted_comment(comment)
    if self.upvoted_comments.nil?
      return
    else
      self.upvoted_comments.delete(comment.id)
      self.save!
    end
  end

  def remove_downvoted_comment(comment)
    if self.downvoted_comments.nil?
      return
    else
      self.downvoted_comments.delete(comment.id)
      self.save!
    end
  end

  def add_flagged_comment(comment)
    if self.flagged_comments.nil?
      self.flagged_comments = [comment.id]
      self.save!
    else
      self.flagged_comments.push(comment.id)
      self.save!
    end
  end
end
