class VoteSerializer < ActiveModel::Serializer
  attributes :upvotes, :downvotes
  belongs_to :recipe
end
