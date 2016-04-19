class Gif < ActiveRecord::Base
  belongs_to :user
  has_many :votes
  attachment :gif_image
  validate :has_at_least_one_image

  # validates :url, format: { with: URI.regexp, message: 'must be a valid URL like http://media.giphy.com/media/tlpVdqCrewXFC/giphy.gif'}, if: Proc.new { |a| a.url.present? }
  # validates :url, format: { with: %r{.(gif)\Z}i, message: 'must be a GIF like http://media.giphy.com/media/tlpVdqCrewXFC/giphy.gif.' }

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
