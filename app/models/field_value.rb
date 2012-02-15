class FieldValue < ActiveRecord::Base
  belongs_to :field_meta

  def self.values_by_meta_id(meta_id)
    self.where('meta_id = ?', meta_id).order('seq')
  end
end
