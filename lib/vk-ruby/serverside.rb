module VK  
  class Serverside 
    include Core
    include Transformer

    attr_reader :app_secret, :settings, :debug

    def initialize(p={})
      raise 'undefined application id' unless @app_id = p[:app_id] 
      raise 'undefined application secret' unless @app_secret = p[:app_secret] 
      
      @logger = p[:logger] if p[:logger]
      @settings = p[:settings] ||= 'notify,friends,offline' 
      transform base_api, self.method(:vk_call)
    end
  end
end