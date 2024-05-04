# frozen_string_literal: true

require "httparty"

require_relative "tiozao/version"

module Tiozao
  class Error < StandardError; end

  # Get jokes from icanhazdadjoke.com
  class Joke
    @url = "https://icanhazdadjoke.com"
    @headers = {
      "Accept": "application/json",
      "User-Agent": "Piadas de Tiozão"
    }

    def self.random
      HTTParty.get(@url, headers: @headers)["joke"]
    end

    def self.search(term, limit = 3)
      query = { term: term, limit: limit }
      response = HTTParty.get(
        "#{@url}/search",
        headers: @headers,
        query: query
      )
      response["results"].map { |result| result["joke"] }
    end
  end
end
