class IndirizzimacsController < ApplicationController
  before_action :logged_in_employee, only: [:create, :destroy]
  before_action :correct_employee,   only: [:destroy,:update]
  
  def create
    @indirizzimac = current_employee.indirizzimacs.build(indirizzimac_params)
    if @indirizzimac.save
      flash[:success] = "indirizzo MAC creato!"
      redirect_to employee_path(session[:employee_id],:act => 'miaRete')
    else
      @indirizzimacs = current_employee.indirizzimacs.all
      @employee = current_employee
      render 'employees/miaRete'
    end
  end

  def destroy
    @indirizzimac.destroy
    redirect_to employee_path(session[:employee_id],:act => 'miaRete',:del=>'true')
  end
  
  def update
    if @indirizzimac.update_attributes(indirizzimac_params)
      redirect_to employee_path(session[:employee_id],:act => 'miaRete',:del=>'true')
    else
      @indirizzimacs = current_employee.indirizzimacs.all
      @employee=current_employee
      render 'employees/miaRete2'
    end
  end
  
  private

    def indirizzimac_params
      params.require(:indirizzimac).permit(:hostname , :macAddress , :dispositivo , :connessione, :vlan_id)
    end
    
    def correct_employee
      @indirizzimac = current_employee.indirizzimacs.find_by(id: params[:id])
      redirect_to root_url if @indirizzimac.nil?
    end
  
end
