class VisitorsController < ApplicationController
    before_action :logged_in_employee,  only: [:create,    :destroy]
    before_action :correct_employee,    only: [:destroy,   :update ]
    
    def create
        @visitor = current_employee.visitors.build(visitor_params)
        if @visitor.save
            flash[:success] = "Visitatore creato"
            redirect_to employee_path(session[:employee_id], :act => 'visiteOspite')
        else
            @visitors = current_employee.visitors.all
            @employee = current_employee
            render 'employees/visiteOspite'
        end
    end
    
    
    
    
    
    private
    
        def visitor_params
            params.require(:visitor).permit(:nome, :cognome, :sesso, :dataNascita, :nazioneNascita, :luogoNascita, :nazioneResidenza, :cittaResidenza, :indirizzo, :matricola, :email, :password, :employee_id)
        end
        
        def correct_employee
            @visitor = current_employee.visitors.find_by(id: params[:id])
            redirect_to root_url if @visitor.nil?
        end
        
end
