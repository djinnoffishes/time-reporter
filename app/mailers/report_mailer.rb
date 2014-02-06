class ReportMailer < ActionMailer::Base
  include JiraQuery
  
  default from: 'pmo@sleepygiant.com'

  def report_email
    titles = [@tsp_devops = [0,'TSP'],
              @tr_devops  = [0,'TR'], 
              @cs_devops  = [0,'CS'], 
              @tp_devops  = [0,'TP'], 
              @ft_devops  = [0,'FT'], 
              @mx_devops  = [0,'MX']]
    titles.each do |t|
      CLIENT.Issue.jql("project = 'Tilting Point' AND labels = #{t[1]}").each do |i|
        t[0] += i.timespent / 3600
      end
    end
    mail(to: 'mitch.yarchin@sleepygiant.com', subject: 'TP Time Reports - ' + Time.now.strftime("%m/%I/%y"))
  end

end
