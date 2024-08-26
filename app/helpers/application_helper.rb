require 'rqrcode'

module ApplicationHelper
  def qr_code_as_svg(url, options = {})
    defaults = {
        module_size: 7,
        use_path: true
    }

    options = defaults.merge(options)

    qrcode = RQRCode::QRCode.new(url)
    
    svg = qrcode.as_svg(options)

    svg.html_safe
  end
end