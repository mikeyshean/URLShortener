class ShortenedUrl < ActiveRecord::Base
 validates :short_url,    :uniqueness => true, :presence => true
 validates :long_url,     :presence => true
 validates :submitter_id, :presence => true

 belongs_to :user,
  :class_name => "User",
  :foreign_key => :submitter_id,
  :primary_key => :id

end
