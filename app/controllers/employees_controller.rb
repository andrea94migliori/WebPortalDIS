class EmployeesController < ApplicationController
    
    def show
        
        if logged_in?
            @employee = Employee.find(params[:id])
            @indirizzimac=current_employee.indirizzimacs.new
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

#Strong parameters for Employee
    private

        def user_params
            params.require(:employee).permit(:nome, :cognome, :sesso,:dataNascita,:nazioneNascita, :luogoNascita, :nazioneResidenza, :cittaResidenza,:indirizzo, :email, :password, :password_confirmation,:terms_of_service)
        end

#Strong parameters for IndirizziMac
   private

        def indirizzimac_params
            params.require(:indirizzimac).permit(:hostname , :macAddress , :dispositivo , :connessione, :vlan)
        end
        
#Strong parameters for Visitor
    private
    
        def visitor_params
            params.require(:visitor).permit(:nome, :cognome, :sesso, :dataNascita, :nazioneNascita, :luogoNascita, nazioneResidenza, cittaResidenza, :indirizzo, :matricola, :email, :password, :password_confirmation)
        end
    

  
end
