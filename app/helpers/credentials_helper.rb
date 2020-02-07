module CredentialsHelper
  def vapid_public_key
    Credentials.vapid_public_key
  end

  def vapid_private_key
    Credentials.vapid_private_key
  end

  def vapid_subject
    Credentials.vapid_subject
  end
end
