require 'open-uri'
require 'RMagick'
include Magick

class Compose

  def initialize(a, b)
    @a = a
    @b = b
  end
  def open_image(user)
    open(avatar_img(user)) do |f|
      Magick::Image.from_blob(f.read).first
    end
  end

  def avatar_img(user)
    "http://identicons.github.com/#{user}.png"
  end

  def image
    a_img = open_image(@a)
    b_img = open_image(@b)
    pair = a_img.composite(b_img, CenterGravity, AddCompositeOp)
    pair.to_blob
  end
end
