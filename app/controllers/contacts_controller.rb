class ContactsController < ApplicationController
    def index
    end

    def create
        @contact = Contact.new(contact_params)
        puts @contact.inspect
        if @contact.save
            flash[:notice] = "Thanks for your message"
            ContactMailer.with(customer: @contact).thanks_mail.deliver_later
            ContactMailer.with(customer: @contact).notification_mail.deliver_later
            redirect_to root_path
        else
            redirect_to root_path, alert: "Something went wrong"
        end
    end

    private
    def contact_params
      params.permit(:name, :mail, :phone_number, :message)
    end
    
end
