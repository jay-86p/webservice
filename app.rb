require 'sinatra'
require 'json'
require 'octokit'

username = ENV['USERNAME']
api_token = ENV['API_TOKEN']
notification_repo = ENV['NOTIFICATION_REPO']

#Used Octokit to authenticate and create issues in GITHUB Repository via API https://github.com/octokit/octokit.rb
Octokit.configure do |c|
  c.login = username
  c.password = api_token
end

#Initial /paylod to test webhook delivery from github
post '/payload' do
  push = JSON.parse(request.body.read)
  puts "I got some JSON: #{push.inspect}"
end

#Listens to the repo-events in the organization's webhooks 
post '/repo-event' do
  begin
    github_event = request.env['HTTP_X_GITHUB_EVENT']
    if github_event == "repository"
      request.body.rewind
      parsed = JSON.parse(request.body.read)
      action = parsed['action']

        #Matches Deleted Events & Creates an issue in the notification_repo
        if action == 'deleted'
          deleted_repo_name = parsed['repository']['full_name']
          client = Octokit::Client.new
		  client.create_issue(notification_repo, "Repository Deleted: #{deleted_repo_name}","Please review the deletion: @#{username}")
          return 201,"Repository Deleted: #{deleted_repo_name}, a Notification is created in #{notification_repo} to review the deletion."
        end
    end
    return 200, "OK Nothing to do!"
  end
end