class VcardsController < ApplicationController
    require 'rqrcode'
    def index
        puts '1234565778899909000'
        puts params[:name]
    end

    def show
        @vcard = Vcard.find(params[:id])
        info = "BEGIN:VCARD\nVERSION:3.0\nN:#{@vcard.name};\nORG:#{@vcard.organization}\nEMAIL;TYPE=INTERNET:#{@vcard.mail}\nTEL:#{@vcard.phone}\nURL:#{@vcard.website}\nADR:#{@vcard.address}\nEND:VCARD"
        qrcode = RQRCode::QRCode.new(info)
        puts qrcode
        # @svg = qrcode.as_svg(
        #     offset: 0,
        #     color: '000',
        #     shape_rendering: 'crispEdges',
        #     module_size: 6,
        #     standalone: true,
        #     use_path: true,
        #     viewbox: true
        # )
        png = qrcode.as_png(
            bit_depth: 1,
            border_modules: 4,
            color_mode: ChunkyPNG::COLOR_GRAYSCALE,
            color: 'black',
            file: nil,
            fill: 'white',
            module_px_size: 6,
            resize_exactly_to: false,
            resize_gte_to: false,
            size: 250
          )
          
          IO.binwrite("./app/assets/images/qrcode.png", png.to_s)
    end

    def download_qrcode
        send_file "#{Rails.root}/app/assets/images/qrcode.png", type: "application/png", x_sendfile: true
    end


    def create
        @vcard = Vcard.new(vcard_params)
        
        # puts @contact.inspect
        if @vcard.save
            flash[:success] = t('vcards.flash_success')
           
            redirect_to @vcard
        else
            flash[:error] = t('vcards.flash_error')
            redirect_to vcards_path
        end
    end

    private
    def vcard_params
      params.permit(:name, :mail, :phone, :address, :organization, :website)
    end
end
