class ContactsController < ApplicationController
    def index
    end

    def create
        @contact = Contact.new(contact_params)
        # puts @contact.inspect
        if @contact.save
            ContactMailer.with(customer: @contact).thanks_mail.deliver_later
            ContactMailer.with(customer: @contact).notification_mail.deliver_later
            flash[:success] = t('contact.flash_success')
            redirect_to root_path
        else
            flash[:error] = t('contact.flash_error')
            redirect_to root_path
        end
    end

    private
    def contact_params
      params.permit(:name, :mail, :phone_number, :message)
    end
    
end
