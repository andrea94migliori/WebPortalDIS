class Indirizzimac < ActiveRecord::Base
  
  VALID_MACADDRESS_REGEX = /\A([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})\z/i
  
  belongs_to :employee
  belongs_to :vlan
  default_scope -> { order(:created_at) }
  validates :employee_id, presence: true
  validates :vlan_id, presence: true
  validates :hostname, presence: true, length: { maximum: 20 , minimum: 2 }, uniqueness: { scope: :employee_id}
  validates :macAddress, presence: true, length: { maximum: 17 , minimum: 17 },format: { with: VALID_MACADDRESS_REGEX },uniqueness: { case_sensitive: false }
  validates :dispositivo, presence: true
  validates :connessione, presence: true
end
