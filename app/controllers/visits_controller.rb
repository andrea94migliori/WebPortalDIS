class VisitsController < ApplicationController
    before_action :logged_in_employee,  only: [:create,    :destroy]
    before_action :correct_employee,    only: [:destroy,   :update ]
    
    def create
        @visit = current_employee.visits.build(visit_params)
        if @visit.save
            flash[:success] = "Visita aggiunta"
            redirect_to employee_path(session[:employee_id], :act => 'visiteOspite')
        else
            @visits = current_employee.visits.all
            @employee = current_employee
            render 'employees/visiteOspite'
        end
    end
    
    
    
    private
    
        def visit_params
            params.require(:visit).permit(:dal, :al, :visitor_id, :employee_id, :status)
        end
    
        def correct_employee
            @visit = current_employee.visits.find_by(id: params[:id])
            redirect_to root_url if @visit.nil?
        end
end
