class Photo < ActiveRecord::Base
  belongs_to :item, :foreign_key => :attachable_id

  # paperclip method
  has_attached_file :data,
      :styles => {
          :large => '800x800>',
          :medium => '300x300>',
          :thumb => '100x100>' 
      }
  
  validates_attachment_presence :data
  validates_attachment_size :data, :less_than => 2.megabytes
  validates_attachment_content_type :data, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif']
end
