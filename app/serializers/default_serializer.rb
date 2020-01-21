class DefaultSerializer < ActiveModel::Serializer

  attributes :id

  def id
    object.id
  rescue StandardError
    0
  end
end
