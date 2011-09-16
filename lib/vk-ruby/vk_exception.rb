module VK

  class VkException < Exception
    attr_reader :vk_method, :error_code, :error_msg

    def initialize(vkmethod, error_hash)
      @vk_method = vkmethod
      @error_code = error_hash['error']['error_code'].to_i
      @error_msg = "Error #{@error_code} in `#{@vk_method}' - #{error_hash['error']['error_msg']}"
      super @error_msg
    end
  end

  class VkAuthorizeException < Exception
    attr_reader :error, :error_msg

    def initialize(error_hash)
      @error = error_hash['error']
      @error_msg = "Error #{@error} - #{error_hash['error_description']}"
      super @error_msg
    end
  end

end