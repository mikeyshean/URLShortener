class Topic < ActiveRecord::Base
  #eventually will have has many shortenedUrls
  has_many :taggings,
  :class_name => "Tagging",
  :foreign_key => :topic_id,
  :primary_key => :id

  has_many :shortened_urls, through: :taggings

end
