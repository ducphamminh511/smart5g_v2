class ContactMailer < ApplicationMailer
    default from: 'benz@smart5g.vn'
    def thanks_mail
        @customer = params[:customer]
        
        mail(to: @customer.mail, subject: "Thank you for your message")
    end

    def notification_mail
        @customer = params[:customer]
        
        mail(to: ['minhduc@smart5g.vn','ngochuyen@smart5g.vn'], subject: "There's new contact from website")
    end
    
end
