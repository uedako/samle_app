class User < ActiveRecord::Base
  has_secure_password
  
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  before_save { email.downcase! } 


  HUMANIZED_KEY_NAMES = {
    :name => "名前",
    :email => "メールアドレス",
    :password => "パスワード",
    :password_confirmation => "パスワード"
  }

  class << self
    def human_attribute_name(attribute_key_name, options = {})
      HUMANIZED_KEY_NAMES[attribute_key_name.intern] || super
    end
  end


end
