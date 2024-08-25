require 'rqrcode'

module ApplicationHelper
  def qr_code_as_svg(url)
    qrcode = RQRCode::QRCode.new(url)
    
    svg = qrcode.as_svg(
      color: "000",
      shape_rendering: "crispEdges",
      module_size: 11,
      standalone: true,
      use_path: true
    )

    svg.html_safe
  end
end