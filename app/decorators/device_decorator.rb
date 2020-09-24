require 'device_detector'

class DeviceDecorator
  attr_reader :user_agent

  def initialize(user_agent:)
    @user_agent = user_agent
  end

  def browser
    client&.name
  end

  def name
    client&.device_name
  end

  def recognized?
    client.known?
  end

  def os
    [client&.os_name, os_major_version].compact.join(' ').presence
  end

  private

  def client
    @client ||= DeviceDetector.new(user_agent)
  end

  def os_major_version
    client&.os_full_version&.split('.')&.first
  end
end
