require 'rubygems'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pony'
require 'pry' if development?

configure :production do
  set   :email_address => 'smtp.sendgrid.net',
        :email_user_name => ENV['SENDGRID_USERNAME'],
        :email_password =>  ENV['SENDGRID_PASSWORD'],
        :email_domain => 'heroku.com'
end

helpers do

  def send_message
    Pony.mail(
      :from => params[:name] + "<" + params[:email] + ">",
      :to => 'adames.larry@gmail.com',
      :subject => params[:subject],
      :body => params[:message],
      :via => :smtp,
      :via_options => {
        :address              => 'smtp.gmail.com',
        :port                 => '587',
        :domain => 'localhost.localdomain',
        :user_name            => 'adames.larry',
        :password             => '10Batman05#',
        :authentication       => :plain,
        :enable_starttls_auto => true
      })
  end

end


get '/' do
  send_file File.join(settings.public_folder, 'index.html')
end

post '/contact' do
  send_message
  redirect to('/')
end
