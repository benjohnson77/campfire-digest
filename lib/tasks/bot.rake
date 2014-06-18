
# called with cd /data/appname/current && bundle exec rake rake ic_bot:send_digest
namespace :bot do
	desc "campfirenow task that pulls all campfire events and sends out a daily digest"

	task :send_digest do
		require 'rubygems'
		require 'open-uri'
		require 'nokogiri'
		require 'yaml'

		# chose to put a user mapping, and some messy stuff into a yaml file
		config = YAML.load_file('lib/tasks/bot.yml')
		user = config['user']
		pass = config['pass']
		url = config['url']

		# hit the campfire API to get the transcript for 1 day
    	doc = Nokogiri::XML(open(url, :http_basic_authentication => [user, pass]))
    	# message body header
    	mb = ''
    	# loop through messages
		doc.xpath('//message').each do |m|
			# ignore the non message message ex: enter room
			next if m.xpath('./body').text == ''
			user_id = m.xpath('./user-id').text
			username = config["m_#{user_id}"]
			message = m.xpath('./body').text
			# build the message body for the email
			mb = mb + "<strong>#{username}: </strong> #{message}<br/><br/>" 
		end	

		# send email from rake, pony made it easier. 
		Pony.mail({
	  		:to => config['to'],
	  		:subject => "Daily Digest from Campfire Room #{Time.now.to_date}",
	  		:via => :smtp,
	  		:via_options => {
		    	:address              => 'smtp.gmail.com',
		    	:port                 => '587',
		    	:enable_starttls_auto => true,
		    	:user_name            => config['email_user'],
		    	:password             => config['email_pass'],
		    	:authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
		    	:domain               => 'yourdomain.com' # the HELO domain provided by the client to the server
		  	},
		  	:html_body => "#{mb}"
		})
	end

end