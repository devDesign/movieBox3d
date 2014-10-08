class Movie < ActiveRecord::Base
  has_many :reviews
  has_many :actors
  has_many :genres
  mount_uploader :image, ImageUploader

  validates :title,
    presence: true,
    uniqueness: true

  def review_average
    reviews.sum(:rating_out_of_ten)/reviews.size
  end
scope :search_genre, -> (name) { Movie.joins(:genres).merge(Genre.genre(name)) }

=begin

scope :search_action, -> (name) { Movie.joins(:genres).merge(Genre.action) }
scope :search_comedy, -> (name) { Movie.joins(:genres).merge(Genre.comedy) }
scope :search_animation, -> (name) { Movie.joins(:genres).merge(Genre.animation) }
scope :search_crime, -> (name) { Movie.joins(:genres).merge(Genre.crime )} 
scope :search_drama, -> (name) { Movie.joins(:genres).merge(Genre.drama )} 
scope :search_fantasy, -> (name) { Movie.joins(:genres).merge(Genre.fantasy )} 
scope :search_history, -> (name) { Movie.joins(:genres).merge(Genre.history )} 
scope :search_music, -> (name) { Movie.joins(:genres).merge(Genre.music )} 
scope :search_romance, -> (name) { Movie.joins(:genres).merge(Genre.romance )} 
scope :search_war, -> (name) { Movie.joins(:genres).merge(Genre.war) } 
scope :search_adventure, -> (name) { Movie.joins(:genres).merge(Genre.adventure )} 
scope :search_documentary, -> (name) { Movie.joins(:genres).merge(Genre.documentary )} 
scope :search_family, -> (name) { Movie.joins(:genres).merge(Genre.family )} 
scope :search_foreign, -> (name) { Movie.joins(:genres).merge(Genre.foreign )} 
scope :search_horror, -> (name) { Movie.joins(:genres).merge(Genre.horror )} 
scope :search_mystery, -> (name) { Movie.joins(:genres).merge(Genre.mystery )} 
scope :search_thriller, -> (name) { Movie.joins(:genres).merge(Genre.thriller )} 
scope :search_western, -> (name) { Movie.joins(:genres).merge(Genre.western )} 

=end
scope :search_actor, -> (name) { Movie.joins(:actors).merge(Actor.search_actor(name))}

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
