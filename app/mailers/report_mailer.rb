class ReportMailer < ActionMailer::Base
  include JiraQuery
  
  default from: 'pmo@sleepygiant.com'
  default reply_to: 'mitch.yarchin@sleepygiant.com'

  def report_email
    @start_of_week = (DateTime.now - 7).strftime("%D")
    @now = DateTime.now.strftime("%D")
    @start_of_month = (DateTime.now - 30).strftime("%D")
   
    # devops total hours
    devops = [@tsp_devops_t = [0,'TSP'],
              @tr_devops_t  = [0,'TR'], 
              @cs_devops_t  = [0,'CS'], 
              @tp_devops_t  = [0,'TP'], 
              @ft_devops_t  = [0,'FT'], 
              @mx_devops_t  = [0,'MX']]
    devops.each do |t|
      CLIENT.Issue.jql("project = 'Tilting Point' AND labels = #{t[1]} AND assignee in membersOf('sleepygiant-infra')").each do |i|
        t[0] += i.aggregatetimespent / 3600 if i.aggregatetimespent
      end
    end
    
    # pm total hours
    pm = [@tsp_pm_t = [0,'TSP'],
          @tr_pm_t  = [0,'TR'], 
          @cs_pm_t  = [0,'CS'], 
          @tp_pm_t  = [0,'TP'], 
          @ft_pm_t  = [0,'FT'], 
          @mx_pm_t  = [0,'MX']]
    pm.each do |t|
      CLIENT.Issue.jql("project = 'Tilting Point' AND labels = #{t[1]} AND assignee in membersOf('sleepygiant-pmo')").each do |i|
        t[0] += i.aggregatetimespent / 3600 if i.aggregatetimespent
      end
    end

    # devops weekly hours
    devops = [@tsp_devops_w = [0,'TSP'],
              @tr_devops_w  = [0,'TR'], 
              @cs_devops_w  = [0,'CS'], 
              @tp_devops_w  = [0,'TP'], 
              @ft_devops_w  = [0,'FT'], 
              @mx_devops_w  = [0,'MX']]
    devops.each do |t|
      CLIENT.Issue.jql("project = 'Tilting Point' AND labels = #{t[1]} AND assignee in membersOf('sleepygiant-infra') AND updatedDate >= startOfWeek()").each do |i|
        t[0] += i.aggregatetimespent / 3600 if i.aggregatetimespent
      end
    end

    # pm weekly hours
    pm = [@tsp_pm_w = [0,'TSP'],
          @tr_pm_w  = [0,'TR'], 
          @cs_pm_w  = [0,'CS'], 
          @tp_pm_w  = [0,'TP'], 
          @ft_pm_w  = [0,'FT'], 
          @mx_pm_w  = [0,'MX']]
    pm.each do |t|
      CLIENT.Issue.jql("project = 'Tilting Point' AND labels = #{t[1]} AND assignee in membersOf('sleepygiant-pmo') AND updatedDate >= startOfWeek()").each do |i|
        t[0] += i.aggregatetimespent / 3600 if i.aggregatetimespent
      end
    end

    # devops monthly hours
    devops = [@tsp_devops_m = [0,'TSP'],
              @tr_devops_m  = [0,'TR'], 
              @cs_devops_m  = [0,'CS'], 
              @tp_devops_m  = [0,'TP'], 
              @ft_devops_m  = [0,'FT'], 
              @mx_devops_m  = [0,'MX']]
    devops.each do |t|
      CLIENT.Issue.jql("project = 'Tilting Point' AND labels = #{t[1]} AND assignee in membersOf('sleepygiant-infra') AND updatedDate >= startOfMonth()").each do |i|
        t[0] += i.aggregatetimespent / 3600 if i.aggregatetimespent
      end
    end

    # pm monthly hours
    pm = [@tsp_pm_m = [0,'TSP'],
          @tr_pm_m  = [0,'TR'], 
          @cs_pm_m  = [0,'CS'], 
          @tp_pm_m  = [0,'TP'], 
          @ft_pm_m  = [0,'FT'], 
          @mx_pm_m  = [0,'MX']]
    pm.each do |t|
      CLIENT.Issue.jql("project = 'Tilting Point' AND labels = #{t[1]} AND assignee in membersOf('sleepygiant-pmo') AND updatedDate >= startOfMonth()").each do |i|
        t[0] += i.aggregatetimespent / 3600 if i.aggregatetimespent
      end
    end

    mail(to: 'mitch.yarchin@sleepygiant.com, wabbitsnot@gmail.com', subject: 'TP Time Reports - ' + Time.now.strftime("%D"))
  end

end
