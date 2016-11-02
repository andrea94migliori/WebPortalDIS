class EmployeesController < ApplicationController
    after_action :update_status,  only: :show
    
    def show
        
        if logged_in?
            @employee = Employee.find(params[:id])
            @indirizzimac = current_employee.indirizzimacs.new
            @visitor = current_employee.visitors.new
            @visit = current_employee.visits.new
            @visits = current_employee.visits.all
            if params[:act]=='mieiDati'
                render 'mieiDati'
            elsif params[:act]=='miaRete'
                if params[:dispositivo].present?
                    if params[:order].present?
                        if params[:order]=='asc'
                            @indirizzimacs= Employee.find(params[:id]).indirizzimacs.where('dispositivo=?', params[:dispositivo]).reorder(params[:subject])
                        else
                            @indirizzimacs= Employee.find(params[:id]).indirizzimacs.where('dispositivo=?', params[:dispositivo]).reorder(params[:subject]+' DESC')
                        end
                    else
                        @indirizzimacs= Employee.find(params[:id]).indirizzimacs.where('dispositivo=?', params[:dispositivo])
                    end
                else
                    if params[:order].present?
                        if params[:order]=='asc'
                            @indirizzimacs= Employee.find(params[:id]).indirizzimacs.all.reorder(params[:subject])
                        else
                            @indirizzimacs= Employee.find(params[:id]).indirizzimacs.all.reorder(params[:subject]+' DESC')
                        end
                    else
                        @indirizzimacs= current_employee.indirizzimacs.all
                    end
                end
                if params[:del].present?
                    #@indirizzimacs = current_employee.indirizzimacs.all
                    render 'miaRete2'
                else
                    render 'miaRete'
                end
            elsif params[:act]=='utenzeTemporanee'
                render 'utenzeTemporanee'
            elsif params[:act]=='visiteOspite'
                render 'visiteOspite'
            elsif params[:act]=='mioAccount'
                render 'mioAccount'
            else
                render 'show'
            end
        else
            render 'static_pages/errorPage'
        end
    end
  
  
    def new
        @employee = Employee.new
    end
  
    def create
        @employee = Employee.new(user_params)
        if @employee.save
            EmployeeMailer.registration_confirmation(@employee).deliver_now
            flash[:success] = "Please confirm your email address to continue"
            render 'email-sent'
        else
            flash[:error] = "Ooooppss, something went wrong!"
            render 'confirm'
        end
    end
    
    def update
        @employee = Employee.find(params[:id])
        if @employee.update_attributes(user_params)
            flash[:success] = "Changes saved successfully"
            render 'mioAccount'
        else
            render 'mioAccount'
        end
    end

  
    def confirm
        @employee=Employee.new(user_params)
        unless @employee.valid?
            render :new
        end
    end
  
    def confirm_email
        employee = Employee.find_by_confirm_token(params[:id])
        if employee
            employee.email_activate
            flash[:success] = "Welcome to the Sample App! Your email has been confirmed.
            Please sign in to continue."
            render 'email-confirmed'
        else
            flash[:error] = "Sorry. User does not exist"
            redirect_to root_url
        end
    end
    
    
    private
    
        def update_status
            if @visits.any?
                @visits.each do |visit|
                    visit.check_visit_status
                end
            end
        end

#Strong parameters for Employee
    private

        def user_params
            params.require(:employee).permit(:nome, :cognome, :sesso,:dataNascita,:nazioneNascita, :luogoNascita, :nazioneResidenza, :cittaResidenza,:indirizzo, :email, :password, :password_confirmation,:terms_of_service, :lingua, :reset_digest, :reset_sent_at)
        end

#Strong parameters for IndirizziMac
   private

        def indirizzimac_params
            params.require(:indirizzimac).permit(:hostname , :macAddress , :dispositivo , :connessione, :vlan)
        end
        
#Strong parameters for Visitor
    private
    
        def visitor_params
            params.require(:visitor).permit(:nome, :cognome, :sesso, :dataNascita, :nazioneNascita, :luogoNascita, :nazioneResidenza, :cittaResidenza, :indirizzo, :matricola, :email, :password, :employee_id)
        end

#Strong parameters for Visit
    private
    
        def visit_params
            params.require(:visit).permit(:dal, :al, :visitor_id, :employee_id, :status)
        end
end
