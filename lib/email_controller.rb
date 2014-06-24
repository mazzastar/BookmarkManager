require 'rest_client'

module Email

	def send_recovery_email(token, email, host)
	  RestClient.post "https://api:key-2-kpn10yx1x2s6j02o6vd6w5tu-8kz66"\
	  "@api.mailgun.net/v2/sandbox67c73ee0368549c9b5353e6f842414d4.mailgun.org/messages",
	  :from => "Mailgun Sandbox <postmaster@sandbox67c73ee0368549c9b5353e6f842414d4.mailgun.org>",
	  :to => "#{email}",
	  :subject => "Password Recovery for Bookmark manager",
	  :text => "Recovery Token for #{email}: http://#{host}/users/reset_password/#{token}"
	end

end