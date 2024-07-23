require 'httparty'

class NodeUserService
  include HTTParty
  base_uri 'http://localhost:8080'

  def self.authenticate_user(params)
    uri = URI("#{base_uri}/authenticate")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
    request.body = params.to_json

    puts "Sending request to Node.js server: #{request.body}" # Log request body
    response = http.request(request)
    puts "Response from Node.js server: #{response.body}" # Log response body

    response
  end

  def self.all_users
    get('/users')
  end

  def self.fetch_user(user_id)
    uri = URI("#{base_uri}/users/#{user_id}")
    response = Net::HTTP.get_response(uri)
    puts "Fetched user: #{response.body}" if response.is_a?(Net::HTTPSuccess)
    response
  end

  def self.create_user(user_params)
    post('/users', body: user_params.to_json, headers: { 'Content-Type' => 'application/json' })
  end

  def self.update_user(id, user_params)
    put("/users/#{id}", body: user_params.to_json, headers: { 'Content-Type' => 'application/json' })
  end

  def self.delete_user(id)
    delete("/users/#{id}")
  end

  def self.get_user(id)
    get("/users/#{id}")
  end
end
