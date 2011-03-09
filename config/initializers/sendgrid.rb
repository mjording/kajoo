ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => "587",
  :authentication => :plain,
  :user_name      => 'accounts@kajoo.org',
  :password       => 'k@j0023',
  :domain         => 'kajoo.org'
}