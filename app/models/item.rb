class Item < ActiveRecord::Base
  STEPS = %w[common description image]

  after_initialize :init
  before_save :set_represent_image

  belongs_to :user
  has_many :photos, :autosave => false, :dependent => :destroy, :foreign_key => :attachable_id
  has_one :category, :primary_key => :category_id, :foreign_key => :id
  has_one :represent, :class_name => 'Photo', :primary_key => :represent_image, :foreign_key => :id
  has_one :location, :class_name => 'Location', :primary_key => :location_id, :foreign_key => :id

  validates :title, :presence => true

  accepts_nested_attributes_for :photos, :allow_destroy => true
  code_field :shipping_method => 1

  # conditional indexing
  searchable :if => :confirmed do
    text :title, :as => :title_korean
    text :description, :as => :description_korean

    integer :price, :shipping_cost, :location_id
    integer :category_hierarchy, :multiple => true

    string :represent_image, :contact
    string :shipping_method
    string :location_si do
      location.try(:si)
    end
    time :created_at, :updated_at
    # Geospatial search is not implemented yet in sunspot 1.3.0
    # It will contain in version 2.0
    latlon(:location) { Sunspot::Util::Coordinates.new( location.latitude, location.longitude ) unless location.blank? }
  end

  # ActiveRecord::AssociatedAttributes 클래스는
  # update시 기본적으로 id, foreign_key를 조건으로 레코드를 찾는다.
  # 따라서 이번 경우와 같이 새로운 레코드가 추가될 경우에는 
  # 레코드를 찾을 수 없어 에러가 나므로 이 메서드를 추가해주었다.
  # TODO - 어뷰징 방지 로직을 넣자. 소유자 체크, 이미 등록된 사진인지 체크.
  def photos_attributes=(attributes)
    attributes.each do |key, attr|
      photos.push(Photo.find(attr['id']))
    end
  end

  def set_represent_image
    self.represent_image = photos.first.try(:id)
  end

  def category_hierarchy
    self.category.hierarchy.map { |c| c.id } unless self.category.blank?
  end

  def init
    self.step ||= steps.first
  end

  def current_step
    self.step
  end

  def steps
    STEPS
  end

  def next_step
    self.step = steps[steps.index(self.step)+1]
  end

  def previous_step
    self.step = steps[steps.index(self.step)-1]
  end

  def first_step?
    self.step == steps.first
  end

  def last_step?
    self.step == steps.last
  end

  def all_valid?
    steps.all? do |s|
      self.step = s
      valid?
    end
  end

end

