module VK
  module Core
    attr_accessor :debug, :logger
    attr_reader :app_id

    def authorize(code = nil)
      prms = {:client_id => @app_id, :client_secret => @app_secret}
      unless code # secure server
        prms[:grant_type] = 'client_credentials'
      else # serverside app
        prms[:code] = code
      end

      query = {:debug => @debug, :path => "/oauth/access_token", :params => prms }
      result = JSON.parse(request(query).body)

      raise result['error'] if result['error']
      @expires_in = result["expires_in"] if result['expires_in']
      @user_id = result["user_id"] if result['user_id']
      @access_token = result["access_token"] if result['access_token']

      result
    end

    private 

    def vk_call(method_name,p)
      p[0].delete(:format) == :xml ? format = '.xml' : foramt = ''
      path = "/method/#{method_name}#{format}"
      prms = p[0].merge :access_token => @access_token
      query = {:debug => @debug, :path => path, :params => prms }
      request(query).body
    end

    def request(p={})
      host = p[:host] ||='api.vk.com'
      port = p[:port] ||=443
      http = Net::HTTP.new(host,port)

      http.set_debug_output(@logger) if @logger

      unless  p[:ssl] == false
        http.use_ssl =  true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end

      prms = "?" + (p[:params].map{|k,v| "#{k}=#{v}" }).join('&')
      http.request(Net::HTTP::Get.new(p[:path] + prms))     
    end

    def base_api
      @@base_api ||= YAML.load_file( File.expand_path( File.dirname(__FILE__) + "/api/base.yml" ))
    end

    def ext_api
      @@ext_api ||= YAML.load_file( File.expand_path( File.dirname(__FILE__) + "/api/ext.yml" ))
    end

    def secure_api
      @@secure_api ||= YAML.load_file( File.expand_path( File.dirname(__FILE__) + "/api/secure.yml" ))
    end
  end
end