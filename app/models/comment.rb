class Comment < ApplicationRecord
  belongs_to :post, counter_cache: true
  belongs_to :user
  alias author user

  after_create :update_comments_counter
  validates :author, presence: true
  validates :text, presence: true

  private

  def update_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
