module VK  
  class Secure
    include Core
    include Transformer

    attr_reader :app_secret

    def initialize(p={})
      raise 'undefined application id' unless @app_id = p[:app_id]  
      raise 'undefined application secret' unless @secret = p[:app_secret]
      transform secure_api, self.method(:vk_call)
    end
  end
end