# frozen_string_literal: true

# ApplicationMailer is the base mailer class from which all other mailers inherit.
# It sets default settings and configurations for all outgoing emails in the application.

class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
