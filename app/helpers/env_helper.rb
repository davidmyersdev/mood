module EnvHelper
  def app_env
    Rails.env.presence
  end

  def sentry_client_dsn
    Env.sentry_client_dsn
  end

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
