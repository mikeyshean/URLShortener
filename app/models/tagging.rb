class Tagging < ActiveRecord::Base
  belongs_to :topic,
   :class_name => "Topic",
  :foreign_key => :topic_id,
  :primary_key => :id

  belongs_to :shortened_url,
   :class_name => "ShortenedUrl",
  :foreign_key => :shortened_url_id,
  :primary_key => :id

  def self.record_tag!(topic_id, shortened_url)
    Tagging.create!(topic_id: topic_id, shortened_url_id: shortened_url.id )
  end

  def inspect
    p topic_id, shortened_url_id, created_at
  end

end
