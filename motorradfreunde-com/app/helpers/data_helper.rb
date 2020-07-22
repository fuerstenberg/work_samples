module DataHelper

  def data_user_id(user, data_hash = {})
    if user
      ({
        "user-id" => user.id
      }).merge data_hash
    else
      data_hash
    end
  end

end
