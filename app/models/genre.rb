class Genre < ActiveRecord::Base
  belongs_to :movie
  scope :genre, -> (name) { where(genre: name) }


  scope :action, -> { where(genre: 'Action') }
  scope :comedy, -> { where(genre: 'Comedy') }
  scope :animation, -> { where(genre: 'Animation') }
  scope :crime, -> { where(genre: 'Crime') }
  scope :drama, -> { where(genre: 'Drama') }
  scope :fantasy, -> { where(genre: 'Fantasy') }
  scope :history, -> { where(genre: 'History') }
  scope :music, -> { where(genre: 'Music') }
  scope :romance, -> { where(genre: 'Romance') }
  scope :war, -> { where(genre: 'War') }
  scope :adventure, -> { where(genre: 'Adventure') }
  scope :documentary, -> { where(genre: 'Documentary') }
  scope :family, -> { where(genre: 'Family') }
  scope :foreign, -> { where(genre: 'Foreign') }
  scope :horror, -> { where(genre: 'Horror') }
  scope :mystery, -> { where(genre: 'Mystery') }
  scope :thriller, -> { where(genre: 'Thriller') }
  scope :western, -> { where(genre: 'Western') }


end
