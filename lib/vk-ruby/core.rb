require 'net/http/post/multipart'

module VK
  module Core
    attr_accessor :debug, :logger
    attr_reader :app_id

    def authorize(code = nil)
      prms = {:client_id => @app_id, :client_secret => @app_secret}
      unless code # secure server
        prms[:grant_type] = 'client_credentials'
      else        # serverside app
        prms[:code] = code
      end

      result = JSON.parse(request({:path => "/oauth/access_token", :params => prms }).body)

      raise result['error'] if result['error']
      @expires_in = result["expires_in"]      if result['expires_in']
         @user_id = result["user_id"]         if result['user_id']
      @access_token = result["access_token"]  if result['access_token']

      result
    end

    private 

    def vk_call(method_name,p)  
      params = p[0] ||= {}
      params[:access_token] = @access_token
      result = JSON.parse request(:path => "/method/#{method_name}", :params => params).body
      raise result['error']['error_msg'] if result['error']
      result['response']
    end

    def request(p={})
      path = p[:path] + "?" + (p[:params].map{|k,v| "#{k}=#{v}" }).join('&')
      http.get path
    end

    def http(p={})
      prms = ({:host => 'api.vk.com', :port => 443, :ssl => true }).merge p
      net = Net::HTTP.new prms[:host], prms[:port]
      net.set_debug_output @logger if @logger && @debug
      unless  prms[:ssl] == false
        net.use_ssl =  true
        net.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
      net
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