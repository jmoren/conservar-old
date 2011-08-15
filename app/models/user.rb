class User < ActiveRecord::Base
  has_friendly_id :full_name, :use_slug => true
  has_paper_trail :only => [:username, :name, :lastname, :email]
  make_flagger
  # new columns need to be added here to be writable through mass assignment
  attr_accessible :username, :email, :password, :password_confirmation, :name, :lastname,:enabled,:role
  has_many :reports
  has_many :tasks
  has_many :galleries
  has_many :photos
  has_many :collections
  has_many :items
  has_many :events
  has_many :alerts
  attr_accessor :password
  before_save :prepare_password

  validates_presence_of :username,:name, :lastname
  validates_uniqueness_of :username, :email, :allow_blank => true, :on => :create
  validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 4, :allow_blank => true

  scope :enabled, where(:enabled => true)

  def has_items_flagged?(flag)
    Item.important(self,flag).size > 0
  end

  # login can be either username or email address
  def self.authenticate(login, pass)
    user = find_by_username(login) || find_by_email(login)
    return user if user && user.password_hash == user.encrypt_password(pass)
  end

  def encrypt_password(pass)
    BCrypt::Engine.hash_secret(pass, password_salt)
  end
  def enabled?
    self.enabled
  end
  def enable
    self.update_attributes(:enabled => true) if !self.enabled?
  end
  def disable
    self.update_attributes(:enabled => false) if self.enabled?
  end
  def full_name
    self.name == 'admin' ? "Admin" : "#{self.name} #{self.lastname}"
  end
  def admin?
    self.role == 'admin'
  end
  private

  def prepare_password
    unless password.blank?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = encrypt_password(password)
    end
  end
end

