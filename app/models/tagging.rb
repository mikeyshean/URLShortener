class Tagging < ActiveRecord::Base
  belongs_to :topic,
   :class_name => "Topic",
  :foreign_key => :topic_id,
  :primary_key => :id

  belongs_to :shortened_url,
   :class_name => "ShortenedUrl",
  :foreign_key => :shortened_url_id,
  :primary_key => :id

  def self.record_tag!(topic, shortened_url)
    Tagging.create!(topic_id: topic.id, shortened_url_id: shortened_url.id )
  end

end
