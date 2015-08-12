class ShortenedUrl < ActiveRecord::Base
  validates :short_url,    :uniqueness => true, :presence => true
  validates :long_url,     :presence => true
  validates :submitter_id, :presence => true

  belongs_to :submitter,
    :class_name => "User",
    :foreign_key => :submitter_id,
    :primary_key => :id

  has_many :visits,
    :class_name => "Visit",
    :foreign_key => :short_url_id,
    :primary_key => :id

  has_many :visitors,
   Proc.new { distinct },
   through: :visits,
   source: :user

  def self.random_code
    short_url = nil

    loop do
      short_url = SecureRandom.urlsafe_base64
      break unless ShortenedUrl.exists?(short_url: short_url)
    end

    short_url
  end

  def self.create_for_user_and_long_url!(user, long_url)
    last = ShortenedUrl.create!(short_url: self.random_code, long_url: long_url, submitter_id: user.id)
    last.short_url
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    visits.select(:user_id).distinct.where({created_at: 10.minutes.ago..(Time.now)}).count
  end
end
