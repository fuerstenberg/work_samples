class BaseSerializer < ActiveModel::Serializer

  attributes :id, :createdAt, :updatedAt

  def id
    object.id.to_s
  end

  def customerId
    object.customer_id.to_s
  end

  def createdAt
    object.created_at
  end

  def updatedAt
    object.updated_at
  end

end
