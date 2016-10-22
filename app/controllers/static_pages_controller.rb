class StaticPagesController < ApplicationController
  def home
    if logged_in?
      render 'employees/show'
    end
  end

  def normeAccessoRete
  end

  def privacyPolicy
  end
end
