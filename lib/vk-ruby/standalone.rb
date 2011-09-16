module VK
  class Standalone 
    include Core
    include Transformer

     attr_accessor :settings

    def initialize(p={})
      raise 'undefined application id' unless @app_id = p[:app_id]

      @scope = p[:scope] ||= 'notify,friends'
      transform base_api, self.method(:vk_call)
      transform ext_api, self.method(:vk_call)
    end

  end
end