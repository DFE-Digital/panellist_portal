require "net/http"
require "pry"

class Services::CrmClient
  class << self
    attr_accessor :access_token
  end

  def initialize
  end

  def entities
    return @entities if @entities

    uri = URI("#{resource}/api/data/v8.2/")

    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = "Bearer #{access_token}"

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    @entities = JSON.parse(response.body)
  end

  def entity(thing:, filters: {})
    uri_string = "#{resource}/api/data/v8.2/#{thing}"

    if filters.any?
      uri_string << "?$filter="

      filters.each do |k,v|
        uri_string << "#{k} eq '#{v}'"
      end
    end

    uri = URI(uri_string)

    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = "Bearer #{access_token}"

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    JSON.parse(response.body)
  end

  # resource example: "contacts(contact-guid-goes-here)"
  def update(resource:, attributes: {})
    uri = URI("#{resource}/api/data/v8.2/#{resource}")

    request = Net::HTTP::Patch.new(uri)
    request["Authorization"] = "Bearer #{access_token}"
    request["Content-Type"] = "application/json"
    request.body = attributes.to_json

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    puts response.body

    response.code == "204"
  end

  private

  def access_token
    return self.class.access_token if self.class.access_token

    puts "fetching new access token..."

    response = Net::HTTP.post_form(token_uri, grant_type:, resource:, client_id:, client_secret:)

    self.class.access_token = JSON.parse(response.body).dig("access_token")
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
