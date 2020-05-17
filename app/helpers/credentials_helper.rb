module CredentialsHelper
  def vapid_public_key
    Env.vapid_public_key
  end

  def vapid_private_key
    Env.vapid_private_key
  end

  def vapid_subject
    Env.vapid_subject
  end
end
