class ParametersController < ApplicationController
  before_action :disconnect_profiless_users
  before_filter :authenticate_administrator!
  before_filter :select_administrator_profile
  before_filter :sign_out_disabled_users

  layout "administrator"

  def index
    @administration_menu_style = 'active'
    @list_parameters_menu_style = 'current'

    @parameter = Parameters.first
  end

  def update
    @administration_menu_style = 'active'
    @list_parameters_menu_style = 'current'
    sill_amount = params[:parameters][:sill_amount]
    @parameter = Parameters.first
    if not_a_number?(sill_amount)
      flash[:error] = "Le montant seuil de rémunération doit être numérique."
    else
      @parameter.update_attributes(sill_amount: sill_amount.to_f)
      flash[:success] = "Les paramètres ont été mis à jour."
    end

    render :index
  end

end
