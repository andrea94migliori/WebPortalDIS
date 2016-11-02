class Visit < ActiveRecord::Base
    
    #Relations in db
    belongs_to          :employee
    belongs_to          :visitor
    default_scope   ->  { order(:created_at) }
    
    #Validations
    validates   :dal,           presence: true,     uniqueness: { scope: [:al, :visitor_id] }
    validates   :al,            presence: true
    validates   :visitor_id,    presence: true
    validates   :employee_id,   presence: true
    validates   :status,        presence: true
    validate    :valid_date_range_required
    validate    :visit_uniqueness
    
    
    def valid_date_range_required
        if (dal && al) && (al < dal)
            errors[:base] << "La data di fine della visita non può essere precedente a quella di inizio."
        end
    end
    
    
    def visit_uniqueness
        if Visit.find_by(dal: :dal, al: :al, visitor_id: :visitor_id)
            errors[:base] << "Esiste già una visita con la stessa data di inizio, di fine e con lo stesso
            visitatore"
        end
    end
    
    #check this function
    def check_visit_status
        if self.status != 'Da Confermare'
            if self.dal <= Date.today && self.al >= Date.today
               self.update_attribute :status, 'In Corso'
               #self.status = 'In Corso'
            end
            
            if self.al < Date.today
                self.update_attribute :status, 'Archiviata'
                #self.status = 'Archiviata'
            end
        end
    
    end
    

    

end
