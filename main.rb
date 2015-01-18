require 'rubygems'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pony'
require 'pry'

helpers do

  def send_message
    Pony.mail(
      :from => params[:name] + "<" + params[:email] + ">",
      :to => 'adames.larry@gmail.com',
      :subject => params[:subject],
      :body => params[:message],
      :via => :smtp,
      :via_options => {
        :address              => 'smtp.sendgrid.net',
        :port                 => '587',
        :enable_starttls_auto => true,
        :user_name            => 'adames.larry',
        :password             => '10Batman05#',
        :authentication       => :plain,
        :domain               => 'localhost.localdomain'
      })
  end

end


get '/' do
  erb :home 
end

post '/contact' do
  binding.pry
  send_message
  redirect to('/')
end
