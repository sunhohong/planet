class Item < ActiveRecord::Base
  after_initialize :init

  belongs_to :user
  has_many :photos, :dependent => :destroy, :foreign_key => :id

  validates :title, :presence => true

  # conditional indexing
  searchable :if => :confirmed do
    text :title, :as => :title_korean
    text :description, :as => :description_korean

    string :category, :represent_image, :location
    string :contact, :shipping_method
    integer :price, :shipping_cost
    time :created_at, :updated_at
  end
  
  def init
    self.step ||= steps.first
  end

  def current_step
    self.step
  end

  def steps
    %w[common specific description image]
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

