class Photo < ActiveRecord::Base
  belongs_to :user
  attr_accessor :binary

  def extract_geopoint!
    tags = EXIFR::JPEG.new(binary.path)
    if (exif = tags.exif) && exif[:gps_latitude] && exif[:gps_longitude]
      [:latitude, :longitude].each{|tag|
        (h, m, s) = exif[:"gps_#{tag}"]
        self[tag] = (h + m / 60 + s / 3600).to_f
      }
    end
  end
end
