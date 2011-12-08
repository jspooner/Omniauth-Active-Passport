# Monkeypatching to work with how Active Passport names the access token on a successful response

module OAuth2
  # The OAuth2::Client class
  class Client
    # Initializes an AccessToken by making a request to the token endpoint
    def get_token(params, access_token_opts={})
      opts = {:raise_errors => true, :parse => params.delete(:parse)}
      if options[:token_method] == :post
        opts[:body] = params
        opts[:headers] =  {'Content-Type' => 'application/x-www-form-urlencoded'}
      else
        opts[:params] = params
      end
      response = request(options[:token_method], token_url, opts)
      raise Error.new(response) unless response.parsed.is_a?(Hash) && (response.parsed['access_token'] || response.parsed['accessToken'])
      AccessToken.from_hash(self, response.parsed.merge(access_token_opts))
    end
  end
end