class ReportMailer < ActionMailer::Base
  include JiraQuery
  
  default from: 'example@example.com'
  default reply_to: 'example@example.com'

  def report_email
    @start_of_week = (DateTime.now - 7).strftime("%D")
    @now = DateTime.now.strftime("%D")
    @current_month = Date::MONTHNAMES[Date.today.month]
   
    # devops total hours
    devops = [@example = [0,'ProjectLabel']]
    devops.each do |t|
      CLIENT.Issue.jql("project = 'Project' AND labels = #{example[1]} AND assignee in membersOf('example_jira_user_group')").each do |i|
        t[0] += i.aggregatetimespent / 3600 if i.aggregatetimespent
      end
    end

    mail(to: 'example@example.com', subject: 'Example Time Report - ' + Time.now.strftime("%D"))
  end

end
