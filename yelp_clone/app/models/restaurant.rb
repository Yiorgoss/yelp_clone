class Restaurant < ActiveRecord::Base
  include WithUserAssociationExtension
  validates :name, length: {minimum: 3}, uniqueness: true
  belongs_to :user
  has_many :reviews, dependent: :destroy

  def build_review(attributes = {}, user)
    attributes[:user] ||= user
    reviews.build(attributes)
  end
end
