class Genre < ActiveRecord::Base
  belongs_to :movie
  scope :sci_fi, -> { where(genre: 'Science Fiction') }
 
end
