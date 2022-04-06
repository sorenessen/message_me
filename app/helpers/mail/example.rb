require 'sendgrid-ruby'
include SendGrid

from = SendGrid::Email.new(email: 'sorenessen@gmail.com')
to = SendGrid::Email.new(email: 'grutherf@gmail.com')
# to = SendGrid::Email.new(email: 'sorenessen@gmail.com')
subject = 'New Activity in CatApp'
content = SendGrid::Content.new(type: 'text/plain', value: 'Your friends are trying to reach you. Respond here: https://message-me-se.herokuapp.com/')
mail = SendGrid::Mail.new(from, subject, to, content)

sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
response = sg.client.mail._('send').post(request_body: mail.to_json)
puts response.status_code
puts response.body
puts response.parsed_body
puts response.headers