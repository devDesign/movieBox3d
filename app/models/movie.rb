class Movie < ActiveRecord::Base
  has_many :reviews
  mount_uploader :image, ImageUploader

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true


  validates :release_date,
    presence: true

  validate :release_date_is_in_the_future

  def review_average
    reviews.sum(:rating_out_of_ten)/reviews.size
  end
=begin
  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
=end
scope :search, -> (name) { where("title like ? OR director like ?", "%#{name}%","%#{name}%")}
scope :search_runtime, -> (name) { 
  case name 
  when "Under 90 minutes"
    where("runtime_in_minutes < ?", 90)
  when "Between 90 and 120 minutes"
    where("runtime_in_minutes > ?", 90)
    where("runtime_in_minutes < ?", 120)
  when "Over 120 minutes"
    where("runtime_in_minutes > ?", 120)
  end
  }



  protected




  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the past") if release_date > Date.today
    end
  end

end
