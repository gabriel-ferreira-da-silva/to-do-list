require 'httparty'

class NodeTaskService
  include HTTParty
  base_uri 'http://localhost:8080'

  def self.all_tasks
    get('/tasks')
  end

  def self.fetch_tasks_byuser(user_id)
    uri = URI("#{base_uri}/tasks/byuser/#{user_id}")
    response = Net::HTTP.get_response(uri)
    puts "Fetched tasks: #{response.body}" if response.is_a?(Net::HTTPSuccess)
    response
  end

  def self.create_task(task_params)
    post('/tasks', body: task_params.to_json, headers: { 'Content-Type' => 'application/json' })
  end

  def self.update_task(id, task_params)
    put("/tasks/#{id}", body: task_params.to_json, headers: { 'Content-Type' => 'application/json' })
  end

  def self.delete_task(id)
    delete("/tasks/#{id}")
  end

  def self.get_task(id)
    get("/tasks/#{id}")
  end
end
