# frozen_string_literal: true

require "test_helper"

class TestTiozao < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Tiozao::VERSION
  end

  def test_random
    stubbed_response = {
      "id" => "R7UfaahVfFd",
      "joke" => "a dad joke",
      "status" => 200
    }
    expected_joke = "a dad joke"

    HTTParty.stub :get, stubbed_response do
      assert_equal expected_joke, Tiozao::Joke.random
    end
  end

  def test_search
    stubbed_response = {
      "current_page" => 1,
      "limit" => 20,
      "next_page" => 2,
      "previous_page" => 1,
      "results" => [
        {
          "id" => "M7wPC5wPKBd",
          "joke" => "joke 1"
        },
        {
          "id" => "MRZ0LJtHQCd",
          "joke" => "joke 2"
        },
        {
          "id" => "usrcaMuszd",
          "joke" => "joke 3"
        }
      ],
      "search_term" => "",
      "status" => 200,
      "total_jokes" => 307,
      "total_pages" => 15
    }
    expected_jokes = [
      "joke 1",
      "joke 2",
      "joke 3"
    ]

    HTTParty.stub :get, stubbed_response do
      assert_equal expected_jokes, Tiozao::Joke.search("joke")
    end
  end
end
