class SearchSerializer < ActiveModel::Serializer
  attributes :keyword, :max_time, :allergies

  def allergies
    object.allergies.split(', ')
  end
end
