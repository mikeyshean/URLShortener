class ShortenedUrl < ActiveRecord::Base
 validates :short_url,    :uniqueness => true, :presence => true
 validates :long_url,     :presence => true
 validates :submitter_id, :presence => true

 belongs_to :submitter,
  :class_name => "User",
  :foreign_key => :submitter_id,
  :primary_key => :id

  def self.random_code
    short_url = nil

    loop do
      short_url = SecureRandom.urlsafe_base64
      break unless ShortenedUrl.exists?(short_url: short_url)
    end

    short_url
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(short_url: self.random_code, long_url: long_url, submitter_id: user.id)
  end



end
