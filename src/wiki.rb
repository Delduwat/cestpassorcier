require 'net/http'
require 'uri'
require 'cgi'
require 'json'

# WIKI Constants
WIKI_REST_API = "https://fr.wikipedia.org/api/rest_v1"
WIKI_SUMMARY_EP = "/page/summary/%s"

# Make a GET request on the given URL with a limited number of redirections
# Return a JSON object
def fetch(url, limit=5)
    url = URI(url)
    response = Net::HTTP.get_response(url)
    case response
        when Net::HTTPSuccess then JSON.parse(response.body)
        when Net::HTTPRedirection
            # Update URL path using the given response location
            url.path = "#{url.path.rpartition('/')[0]}/#{response['location']}"
            fetch(url.to_s, limit-1)
        else raise 'HTTP request failed. Status: %d' % response.code
    end
end

# Retrieve a wiki extract from a term
def get_definition(term)
    url = WIKI_REST_API + WIKI_SUMMARY_EP % CGI::escape(term)
    response = fetch(url)
    return response['extract']
end