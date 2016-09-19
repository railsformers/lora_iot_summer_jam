class BaseREST < ::Hashie::Mash
  include Hashie::Extensions::Mash::SafeAssignment
  include ActiveModel::Conversion

  class << self
    attr_accessor :id, :response, :data

    def token
      ""
    end

    def base_url
      "https://api.pripoj.me"
    end

    def singular_name
      self.name.downcase
    end

    def plural_name
      singular_name.pluralize
    end

    def url_builder
      url = [base_url, singular_name, 'get', id].compact.join("/") + "?token=#{token}"
      puts "GET: #{url}"

      url
    end

    def all(params: {})
      cache(url_builder, params) do
      	@response = RestClient.get(url_builder, params)
      end
      parse_response
    end

    def get(_id, params: {})
      @id = _id
      all(params)
    end
    alias_method :find, :get

    private

    def parse_response
      if @response.code == 200
        @data = JSON.parse(@response, symbolize_names: true)
        records = @data[:records]
        return records.is_a?(Array) ? records.map{ |r| self.new(r) } : self.new(records)
      end

      nil
    end


    def cache(url, params, &block)
      Rails.cache.fetch([url, params], expires: 1.hour) do
        yield
      end
    end
  end
end
