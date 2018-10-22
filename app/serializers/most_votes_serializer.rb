class MostVotesSerializer < ActiveModel::Serializer
  attributes :most_votes

  def most_votes
    object.sort_by { |recipe| -recipe[:votes][:upvotes] }
  end
end
