desc 'This task sends the time report email'
task :send_email => :environment do
  ReportMailer.report_email.deliver if Time.now.friday?
end
