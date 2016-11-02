class Employee < ActiveRecord::Base
  
  #Forgotten password
  attr_accessor :remember_token, :activation_token, :reset_token
  
  #BEFORE CONDITIONS
  before_save   { self.email = email.downcase }
  before_create :confirmation_token
  
  #Pattern for email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  #Relations in db
  has_many :indirizzimacs,  dependent:      :destroy
  has_many :visits,         dependent:      :destroy
  has_many :visitors,       dependent:      :destroy
  
  #Validations
  validates :nome,              presence: true,     length: { maximum: 20 , minimum: 2 }
  validates :cognome,           presence: true,     length: { maximum: 20 , minimum: 2 }
  validates :sesso,             presence: true
  validates :dataNascita,       presence: true
  validates :nazioneNascita,    presence: true
  validates :luogoNascita,      presence: true,     length: { maximum: 60 }
  validates :nazioneResidenza,  presence: true
  validates :cittaResidenza,    presence: true,     length: { maximum: 60 }
  validates :indirizzo,         presence: true,     length: { maximum: 60 , minimum: 7 }
  validates :email,             presence: true,     length: { maximum: 243 },               format: { with: VALID_EMAIL_REGEX },    uniqueness: { case_sensitive: false }
  validates :password,                              length: { minimum: 6 }
  validates :terms_of_service,                                                              acceptance: { message: 'devi accettare termini e condizioni' }
  
  #Bcrypt
  has_secure_password
  
  
  # Reset password methods: START
  def create_reset_digest
      self.reset_token = Employee.new_token
      update_attribute(:reset_digest,  Employee.digest(reset_token))
      update_attribute(:reset_sent_at, Time.zone.now)
  end
  
  def send_password_reset_email
      EmployeeMailer.password_reset(self).deliver_now
  end
  
  def Employee.new_token
      SecureRandom.urlsafe_base64
  end
  
  def password_reset_expired?
      reset_sent_at < 2.hours.ago
  end
  
  
  def authenticated?(attribute, token)
      digest = send("#{attribute}_digest")
      return false if digest.nil?
      BCrypt::Password.new(digest).is_password?(token)
  end
  #END
  
  
  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end
  
  private
  def confirmation_token
      if self.confirm_token.blank?
          self.confirm_token = SecureRandom.urlsafe_base64.to_s
      end
  end
  
  def Employee.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
