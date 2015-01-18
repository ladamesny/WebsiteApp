require 'rubygems'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pony'
require 'pry' if development?

helpers do

  def send_message
    Pony.mail(
      :from => params[:name] + "<" + params[:email] + ">",
      :to => 'adames.larry@gmail.com',
      :subject => params[:subject],
      :body => params[:message],
      :via => :smtp,
      :via_options => {
        :address              => 'smtp.sendgrid.com',
        :port                 => '587',
        :domain => 'heroku.com',
        :user_name            => ENV['SENDGRID_USERNAME'],
        :password             => ENV['SENDGRID_PASSWORD'],
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
