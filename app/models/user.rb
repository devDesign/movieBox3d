class User < ActiveRecord::Base
  has_secure_password
  has_many :reviews
  after_destroy :send_email

  def send_email
    DestroyMailer.goodbye_email(self).deliver
  end

  def full_name
    "#{firstname} #{lastname}"
  end
end
