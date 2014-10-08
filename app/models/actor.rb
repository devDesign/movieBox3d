class Actor < ActiveRecord::Base
    scope :search_actor, ->  (name) { where("full_name LIKE ?", "%#{name}%") }
end
