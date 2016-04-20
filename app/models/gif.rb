class Gif < ActiveRecord::Base
  belongs_to :user
  has_many :votes

  validates :url, presence: true,
                  format: { with: URI.regexp, message: 'must be a valid URL like http://media.giphy.com/media/tlpVdqCrewXFC/giphy.gif'}, if: Proc.new { |a| a.url.present? }
  validates :url, format: { with: %r{.(gif)\Z}i, message: 'must be a GIF like http://media.giphy.com/media/tlpVdqCrewXFC/giphy.gif.' }

end
