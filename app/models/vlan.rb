class Vlan < ActiveRecord::Base
  has_many :indirizzimacs
  validates :nome,  presence: true
  validates :vlanID,  presence: true ,uniqueness: true
end
