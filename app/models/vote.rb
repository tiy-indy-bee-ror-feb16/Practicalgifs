class Vote < ActiveRecord::Base
  belongs_to :gif
  belongs_to :user
  validates :user_id, uniqueness: { scope: :gif_id }
end
