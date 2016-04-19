class Gif < ActiveRecord::Base
  belongs_to :user
  has_many :votes
  attachment :gif_image, content_type: "image/gif"
  validate :has_at_least_one_image

  ex_url = "http://media.giphy.com/media/tlpVdqCrewXFC/giphy.gif"
  validates :url, format: { with: URI.regexp,
                            message: "must be a valid URL like #{ex_url}"},
                            if: Proc.new { |a| a.url.present? }
  validates :url, format: { with: %r{.(gif)\Z}i,
                            message: "must be a GIF like #{ex_url}." },
                            if: lambda{ |object| object.url.present? }

  # Validate for image url or gif
  def has_at_least_one_image
    if [url, gif_image].count(&:blank?) == 2
      errors[:base] << "file or url required"
    end
  end

  def has_upload?
    !gif_image.blank?
  end

  def gif_display_url
    if has_upload?
      Refile.attachment_url(self, :gif_image)
    else
      url
    end
  end
end
