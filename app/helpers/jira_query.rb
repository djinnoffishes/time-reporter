module JiraQuery
  
  options = {
              :username => ENV['JIRA_USERNAME'],
              :password => ENV['JIRA_PASSWORD'],
              :site     => ENV['JIRA_SITE'],
              :context_path => '',
              :auth_type => :basic,
              :use_ssl => false
            }
  CLIENT = JIRA::Client.new(options)
end