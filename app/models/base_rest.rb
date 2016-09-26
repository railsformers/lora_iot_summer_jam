class BaseREST < ::Hashie::Mash
  include Hashie::Extensions::Mash::SafeAssignment
  include ActiveModel::Conversion

  class << self
    attr_accessor :id, :response, :data

    @@cache_expires = 1.hour

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

    def params
      all = {}

      all[:token] = token
      all[:offset] = @offset || 0
      all[:limit] = @limit || 25
      all[:order] = @order unless @order
      all[:start] = @start unless @start
      all[:stop] = @stop unless @stop

      all
    end

    def params_str
      "?" + params.delete_if{ |k, v| v.nil? }.map{ |key, value| "#{key}=#{value}" }.join("&")
    end

    def url_builder
      [base_url, singular_name, 'get', id].compact.join("/") + params_str
    end

    def offset(offset)
      @offset ||= offset

      self
    end

    def limit(limit)
      @limit ||= limit

      self
    end

    def order(order)
      @order ||= order

      self
    end

    def start(start)
      @start ||= start

      self
    end

    def stop(stop)
      @stop ||= stop

      self
    end

    def print(url)
      puts "GET" + ( Rails.cache.exist?(cache_key([url, params])) ? " (CACHE " + @@cache_expires.to_i.to_s + "s)" : "" ) + ": #{url}"
    end

    def all
      print(url_builder)
      @response = cache(url_builder) do
        response = RestClient.get(url_builder, params)
	      ::Hashie::Mash.new({ body: response.body, code: response.code, headers: response.headers })
      end
      parse_response
    end

    def get(_id)
      @id = _id

      #LazyObject.new { result }
      result
    end
    alias_method :find, :get

    def page(page)
      @page = page.try(:to_i) || 0
      @offset = (@page * @limit) if @page

      self
    end

    def result
      all
    end
    alias_method :each, :result
    alias_method :[], :result
    alias_method :count, :result
    alias_method :empty?, :result

    private

    def parse_response
      if @response.code == 200
        @data = JSON.parse(@response.body, symbolize_names: true)
        records = @data[:records]
        return records.is_a?(Array) ? records.map{ |r| self.new(r) } : self.new(records)
      end

      nil
    end


    def cache(url, &block)
      Rails.cache.fetch(cache_key([url, params]), expires: @@cache_expires) do
        block.call
      end
    end

    def cache_key(key)
      key
    end

    def cache_expires(expiration_time)
      @@cache_expires = expiration_time
    end
  end
end
