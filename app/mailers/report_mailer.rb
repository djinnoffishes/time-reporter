class ReportMailer < ActionMailer::Base
  include JiraQuery
  
  default from: 'pmo@sleepygiant.com'

  def report_email
    @tsp = CLIENT.Issue.jql("project = 'Tilting Point' AND labels = TSP")
    mail(to: 'mitch.yarchin@sleepygiant.com', subject: 'TP Time Reports - ' + Time.now.strftime("%m/%I/%y"))
  end

end
