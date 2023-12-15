class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  alias_attribute :author, :user

  validates :author, presence: true
  validates :text, presence: true

  after_create :increment_comments_counter
  before_destroy :decrement_comments_counter

  # Uncomment the following lines if you want to validate the presence of author and text
  # validates :author, presence: true
  # validates :text, presence: true

  private

  def increment_comments_counter
    post.increment!(:comments_counter)
  end

  def decrement_comments_counter
    post.decrement!(:comments_counter)
  end
end
