class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_attached_file :avatar, 
    styles: { thumb: '100x100>', medium: '300x300>' }, 
    default_url: '/test.jpg'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end
