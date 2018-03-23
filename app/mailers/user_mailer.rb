class UserMailer < ApplicationMailer

    def welcome(record, token, opts={})
    	@resource = record
	      @token = token
	      mail(to: record.email,
	      	subject: 'Welcome to Cozy Planet!') do |format|
	      	format.html
	      end
	end

end
