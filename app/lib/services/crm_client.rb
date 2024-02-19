require "net/http"
require "pry"

class Services::CrmClient
  def initialize
  end

  def entities
    return @entities if @entities

    uri = URI("")

    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = "Bearer #{access_token}"

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    @entities = JSON.parse(response.body)
  end

  def entity(thing)
    uri = URI("")

    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = "Bearer #{access_token}"

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    JSON.parse(response.body)
  end

  private

  def access_token
    return @access_token if @access_token

    response = Net::HTTP.post_form(token_uri, grant_type:, resource:, client_id:, client_secret:)

    @access_token = JSON.parse(response.body).dig("access_token")
  end

  def token_uri
    URI("https://login.microsoftonline.com/#{tenant}/oauth2/token")
  end

  def tenant
  end

  def grant_type
    "client_credentials"
  end

  def resource
  end

  def client_id
  end

  def client_secret
  end
end
