class CredentialsGenerator < Rails::Generators::Base
  def add_credentials_file
    # generate master key file if it does not exist
    unless master_key_path.exist?
      create_file(master_key_path, ActiveSupport::EncryptedFile.generate_key)

      master_key_path.chmod(0600)
    end

    # generate credentials file if it does not exist
    unless credentials.content_path.exist?
      credentials.write(credentials_template)
    end
  end

  private

  def credentials
    ActiveSupport::EncryptedConfiguration.new(
      config_path: 'config/credentials.yml.enc',
      key_path: 'config/master.key',
      env_key: 'RAILS_MASTER_KEY',
      raise_if_missing_key: true
    )
  end

  def credentials_template
    vapid_keys = Webpush.generate_key

    <<~YAML
      secret_key_base: #{SecureRandom.hex(64)}
      vapid_private_key: #{vapid_keys.private_key}
      vapid_public_key: #{vapid_keys.public_key}
      vapid_subject: https://example.invalid
    YAML
  end

  def master_key_path
    @master_key_path ||= Pathname.new('config/master.key')
  end
end
