module VK
  class Standalone 
    include Core
    include Transformer

    def initialize(p={})
      raise 'undefined application id' unless @app_id = p[:app_id]

      @scope = p[:scope] ||= 'notify,friends'
      transform base_api, self.method(:vk_call)
      transform ext_api, self.method(:vk_call)
    end

    def request(p={})
      path = p[:path] + "?" + (p[:params].map{|k,v| "#{k}=#{v}" }).join('&')
      http.get path, @header
    end

  end
end