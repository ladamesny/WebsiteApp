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
        :domain => 'http://larryadames.herokuapp.com',
        :user_name            => ENV['SENDGRID_USERNAME'],
        :password             => ENV['SENDGRID_PASSWORD'],
        :authentication       => :plain,
        :enable_starttls_auto => true
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
