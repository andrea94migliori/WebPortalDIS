class Visit < ActiveRecord::Base
    
    #Relations in db
    belongs_to          :employee
    belongs_to          :visitor
    default_scope   ->  { order(:created_at) }
    
    #Validations
    validates   :idVisit,   presence: true,     uniqueness: true
    validates   :dal,       presence: true
    validates:  :al,        presence: true,     date: { after_or_equal_to:  :dal }, on: :create
    
end
