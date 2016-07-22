class GamersController < ApplicationController

  before_action :disconnect_profiless_users
  before_filter :authenticate_administrator!
  before_filter :select_administrator_profile
  before_filter :sign_out_disabled_users


  layout "administrator"

  def index
    @class_gamers = "active"
    @gamers = User.all.order("created_at DESC")

    @total_gamers = @gamers.count
    @confirmed_accounts = @gamers.where("confirmed_at IS NOT NULL").count
    @unconfirmed_accounts = @gamers.where("confirmed_at IS NULL").count
  end

  def export_gamers_list
    @users = User.all

    send_data @users.to_csv, filename: "Parieurs-#{Date.today}.csv"
  end

  def profile
    @class_gamers = "active"
    @gamer = User.find_by_id(params[:gamer_id])

    if @gamer.blank?
      flash[:error] = "Cet utilisateur n'existe pas"
      redirect_to gamers_path
    else
      @pmu_plr_bets_count = AilPmu.where("gamer_id = '#{@gamer.uuid}' AND placement_acknowledge IS TRUE").count
      @loto_bets_count = AilLoto.where("gamer_id = '#{@gamer.uuid}' AND placement_acknowledge IS TRUE").count
      @sport_cash_bets_count = Bet.where("gamer_id = '#{@gamer.uuid}' AND ticket_id IS NOT NULL").count
      @cm_bets_count = Cm.where("punter_id = '#{@gamer.uuid}' AND serial_number IS NOT NULL").count
      @eppl_bets_count = Eppl.where("gamer_id = '#{@gamer.uuid}' AND operation != 'Prise de pari' AND operation IS NOT NULL").count
    end
  end

  def all_winners
    @winners_menu_style = "current"
    @all_winners_menu_style = "this"
    @loto_bets = AilLoto.select(:bet_status, :transaction_id, :bet_cost_amount, :earning_amount, :bet_date, :bet_cancelled_at, :begin_date, :end_date, :id).where("bet_status = 'Gagnant' OR bet_status = 'Vainqueur en attente de paiement'").order("created_at DESC")
    @pmu_plr_bets = AilPmu.select(:bet_status, :transaction_id, :bet_cost_amount, :earning_amount, :bet_date, :bet_cancelled_at, :begin_date, :end_date, :id).where("bet_status = 'Gagnant' OR bet_status = 'Vainqueur en attente de paiement'").order("created_at DESC")
    @spc_bets = Bet.select(:bet_status, :transaction_id, :amount, :win_amount, :bet_validated_at, :bet_cancelled_at, :id).where("bet_status = 'Gagnant' OR bet_status = 'Vainqueur en attente de paiement'").order("created_at DESC")
    @cm_bets = Cm.select(:bet_status, :sale_client_id, :amount, :win_amount, :bet_placed_at, :bet_cancelled_at, :begin_date, :end_date, :id).where("bet_status = 'Gagnant' OR bet_status = 'Vainqueur en attente de paiement'").order("created_at DESC")
  end

  def loto_bets
    @class_gamers = "active"
    @gamer = User.find_by_id(params[:gamer_id])

    if @gamer.blank?
      flash[:error] = "Cet utilisateur n'existe pas"
      redirect_to gamers_path
    else
      @loto_bets = AilLoto.where("gamer_id = '#{@gamer.uuid}' AND placement_acknowledge IS TRUE").order("created_at DESC")
    end
  end

  def list_loto_bets
    @games_menu_style = "current"
    @loto_game_menu_style = "this"

    @loto_bets = AilLoto.where("placement_acknowledge IS TRUE").order("created_at DESC")
  end

  def loto_winners
    @winners_menu_style = "current"
    @loto_winners_menu_style = "this"

    @loto_bets = AilLoto.where("bet_status = 'Gagnant' OR bet_status = 'Vainqueur en attente de paiement'").order("created_at DESC")
  end

  def export_loto_winners
    @loto_bets = AilLoto.where("bet_status = 'Gagnant' OR bet_status = 'Vainqueur en attente de paiement'").order("created_at DESC")

    send_data @loto_bets.to_csv, filename: "Gagnants-LOTO-#{Date.today}.csv"
  end

  def list_loto_bet_search
    @games_menu_style = "current"
    @loto_game_menu_style = "this"
    @begin_date = params[:begin_date]
    @end_date = params[:end_date]
    @status = params[:status_id]
    @min_amount = params[:min_amount]
    @max_amount = params[:max_amount]

    params[:begin_date] = @begin_date
    params[:end_date] = @end_date
    params[:status_id] = @status
    params[:min_amount] = @min_amount
    params[:max_amount] = @max_amount

    set_loto_search_params

    @loto_bets = AilLoto.where("#{@sql_begin_date} #{@sql_begin_date.blank? ? '' : 'AND'} #{@sql_end_date} #{@sql_end_date.blank? ? '' : 'AND'} #{@sql_status} #{@sql_status.blank? ? '' : 'AND'} #{@sql_min_amount} #{@sql_min_amount.blank? ? '' : 'AND'} #{@sql_max_amount} #{@sql_max_amount.blank? ? '' : 'AND'} placement_acknowledge IS TRUE").order("created_at DESC")
    flash[:success] = "#{@loto_bets.count} Résultat(s) trouvé(s)."

    if params[:commit] == "Exporter"
      send_data @loto_bets.to_csv, filename: "Parieurs-Loto-#{Date.today}.csv"
    end
  end

  def loto_bet_details
    @class_gamers = "active"
    @bet = AilLoto.find_by_id(params[:bet_id])
    if @bet.blank?
      flash[:error] = "Ce pari n'existe pas"
      redirect_to gamers_path
    else
      @gamer = User.find_by_uuid(@bet.gamer_id)
    end
  end

  def loto_bet_search
    @class_gamers = "active"
    @gamer = User.find_by_uuid(params[:uuid])
    @begin_date = params[:begin_date]
    @end_date = params[:end_date]
    @status = params[:status_id]
    @min_amount = params[:min_amount]
    @max_amount = params[:max_amount]

    if @gamer.blank?
      redirect_to gamers_path
    else
      params[:begin_date] = @begin_date
      params[:end_date] = @end_date
      params[:status_id] = @status
      params[:min_amount] = @min_amount
      params[:max_amount] = @max_amount

      set_loto_search_params

      @loto_bets = AilLoto.where("#{@sql_begin_date} #{@sql_begin_date.blank? ? '' : 'AND'} #{@sql_end_date} #{@sql_end_date.blank? ? '' : 'AND'} #{@sql_status} #{@sql_status.blank? ? '' : 'AND'} #{@sql_min_amount} #{@sql_min_amount.blank? ? '' : 'AND'} #{@sql_max_amount} #{@sql_max_amount.blank? ? '' : 'AND'} gamer_id = '#{@gamer.uuid}' AND placement_acknowledge IS TRUE").order("created_at DESC")
      flash[:success] = "#{@loto_bets.count} Résultat(s) trouvé(s)."
    end
  end

  def pmu_plr_bets
    @class_gamers = "active"
    @gamer = User.find_by_id(params[:gamer_id])

    if @gamer.blank?
      flash[:error] = "Cet utilisateur n'existe pas"
      redirect_to gamers_path
    else
      @pmu_plr_bets = AilPmu.where("gamer_id = '#{@gamer.uuid}' AND placement_acknowledge IS TRUE").order("created_at DESC")
    end
  end

  def list_pmu_plr_bets
    @games_menu_style = "current"
    @pmu_plr_game_menu_style = "this"

    @pmu_plr_bets = AilPmu.where("placement_acknowledge IS TRUE").order("created_at DESC")
  end

  def pmu_plr_winners
    @winners_menu_style = "current"
    @pmu_plr_winners_menu_style = "this"

    @pmu_plr_bets = AilPmu.where("bet_status = 'Gagnant' OR bet_status = 'Vainqueur en attente de paiement'").order("created_at DESC")
  end

  def export_pmu_plr_winners
    @pmu_plr_bets = AilPmu.where("bet_status = 'Gagnant' OR bet_status = 'Vainqueur en attente de paiement'").order("created_at DESC")

    send_data @pmu_plr_bets.to_csv, filename: "Gagnants-PMU-PLR-#{Date.today}.csv"
  end

  def export_pmu_plr_winners_on_hold
    @pmu_plr_bets = AilPmu.where("bet_status = 'Vainqueur en attente de paiement'").order("created_at DESC")

    send_data @pmu_plr_bets.to_csv, filename: "Gagnants-PMU-PLR-en-attente-de-paiement-#{Date.today}.csv"
  end

  def list_pmu_plr_bet_search
    @games_menu_style = "current"
    @pmu_plr_game_menu_style = "this"
    @begin_date = params[:begin_date]
    @end_date = params[:end_date]
    @status = params[:status_id]
    @min_amount = params[:min_amount]
    @max_amount = params[:max_amount]

    params[:begin_date] = @begin_date
    params[:end_date] = @end_date
    params[:status_id] = @status
    params[:min_amount] = @min_amount
    params[:max_amount] = @max_amount

    set_loto_search_params

    @pmu_plr_bets = AilPmu.where("#{@sql_begin_date} #{@sql_begin_date.blank? ? '' : 'AND'} #{@sql_end_date} #{@sql_end_date.blank? ? '' : 'AND'} #{@sql_status} #{@sql_status.blank? ? '' : 'AND'} #{@sql_min_amount} #{@sql_min_amount.blank? ? '' : 'AND'} #{@sql_max_amount} #{@sql_max_amount.blank? ? '' : 'AND'} placement_acknowledge IS TRUE").order("created_at DESC")
    flash[:success] = "#{@pmu_plr_bets.count} Résultat(s) trouvé(s)."

    if params[:commit] == "Exporter"
      send_data @pmu_plr_bets.to_csv, filename: "Parieurs-PMU-PLR-#{Date.today}.csv"
    end
  end

  def pmu_plr_bet_details
    @class_gamers = "active"
    @bet = AilPmu.find_by_id(params[:bet_id])
    if @bet.blank?
      flash[:error] = "Ce pari n'existe pas"
      redirect_to gamers_path
    else
      @gamer = User.find_by_uuid(@bet.gamer_id)
    end
  end

  def pmu_plr_bet_search
    @class_gamers = "active"
    @gamer = User.find_by_uuid(params[:uuid])
    @begin_date = params[:begin_date]
    @end_date = params[:end_date]
    @status = params[:status_id]
    @min_amount = params[:min_amount]
    @max_amount = params[:max_amount]

    if @gamer.blank?
      redirect_to gamers_path
    else
      params[:begin_date] = @begin_date
      params[:end_date] = @end_date
      params[:status_id] = @status
      params[:min_amount] = @min_amount
      params[:max_amount] = @max_amount

      set_pmu_plr_search_params

      @pmu_plr_bets = AilPmu.where("#{@sql_begin_date} #{@sql_begin_date.blank? ? '' : 'AND'} #{@sql_end_date} #{@sql_end_date.blank? ? '' : 'AND'} #{@sql_status} #{@sql_status.blank? ? '' : 'AND'} #{@sql_min_amount} #{@sql_min_amount.blank? ? '' : 'AND'} #{@sql_max_amount} #{@sql_max_amount.blank? ? '' : 'AND'} gamer_id = '#{@gamer.uuid}' AND placement_acknowledge IS TRUE").order("created_at DESC")
      flash[:success] = "#{@pmu_plr_bets.count} Résultat(s) trouvé(s)."
    end
  end

  def spc_bets
    @class_gamers = "active"
    @gamer = User.find_by_id(params[:gamer_id])

    if @gamer.blank?
      flash[:error] = "Cet utilisateur n'existe pas"
      redirect_to gamers_path
    else
      @spc_bets = Bet.where("gamer_id = '#{@gamer.uuid}' AND validated IS TRUE").order("created_at DESC")
    end
  end

  def list_spc_bets
    @games_menu_style = "current"
    @spc_game_menu_style = "this"

    @spc_bets = Bet.where("validated IS TRUE").order("created_at DESC")
  end

  def spc_winners
    @winners_menu_style = "current"
    @spc_winners_menu_style = "this"

    @spc_bets = Bet.where("bet_status = 'Gagnant' OR bet_status = 'Vainqueur en attente de paiement'").order("created_at DESC")
  end

  def export_spc_winners
    @spc_bets = Bet.where("bet_status = 'Gagnant' OR bet_status = 'Vainqueur en attente de paiement'").order("created_at DESC")

    send_data @spc_bets.to_csv, filename: "Gagnants-SPORTCASH-#{Date.today}.csv"
  end

  def export_spc_winners_on_hold
    @spc_bets = Bet.where("bet_status = 'Vainqueur en attente de paiement'").order("created_at DESC")

    send_data @spc_bets.to_csv, filename: "Gagnants-SPORTCASH-en-attente-de-paiement-#{Date.today}.csv"
  end

  def list_spc_bet_search
    @games_menu_style = "current"
    @spc_game_menu_style = "this"
    @begin_date = params[:begin_date]
    @end_date = params[:end_date]
    @status = params[:status_id]
    @min_amount = params[:min_amount]
    @max_amount = params[:max_amount]

    params[:begin_date] = @begin_date
    params[:end_date] = @end_date
    params[:status_id] = @status
    params[:min_amount] = @min_amount
    params[:max_amount] = @max_amount

    set_spc_search_params

    @spc_bets = Bet.where("#{@sql_begin_date} #{@sql_begin_date.blank? ? '' : 'AND'} #{@sql_end_date} #{@sql_end_date.blank? ? '' : 'AND'} #{@sql_status} #{@sql_status.blank? ? '' : 'AND'} #{@sql_min_amount} #{@sql_min_amount.blank? ? '' : 'AND'} #{@sql_max_amount} #{@sql_max_amount.blank? ? '' : 'AND'} validated IS TRUE").order("created_at DESC")
    flash[:success] = "#{@spc_bets.count} Résultat(s) trouvé(s)."

    if params[:commit] == "Exporter"
      send_data @spc_bets.to_csv, filename: "Parieurs-SPORTCASH-#{Date.today}.csv"
    end
  end


  def spc_bet_details
    @class_gamers = "active"
    @bet = Bet.find_by_id(params[:bet_id])
    if @bet.blank?
      flash[:error] = "Ce pari n'existe pas"
      redirect_to gamers_path
    else
      @gamer = User.find_by_uuid(@bet.gamer_id)
    end
  end

  def spc_bet_search
    @class_gamers = "active"
    @gamer = User.find_by_uuid(params[:uuid])
    @begin_date = params[:begin_date]
    @end_date = params[:end_date]
    @status = params[:status_id]
    @min_amount = params[:min_amount]
    @max_amount = params[:max_amount]

    if @gamer.blank?
      redirect_to gamers_path
    else
      params[:begin_date] = @begin_date
      params[:end_date] = @end_date
      params[:status_id] = @status
      params[:min_amount] = @min_amount
      params[:max_amount] = @max_amount

      set_spc_search_params

      @spc_bets = Bet.where("#{@sql_begin_date} #{@sql_begin_date.blank? ? '' : 'AND'} #{@sql_end_date} #{@sql_end_date.blank? ? '' : 'AND'} #{@sql_status} #{@sql_status.blank? ? '' : 'AND'} #{@sql_min_amount} #{@sql_min_amount.blank? ? '' : 'AND'} #{@sql_max_amount} #{@sql_max_amount.blank? ? '' : 'AND'} gamer_id = '#{@gamer.uuid}' AND validated IS TRUE").order("created_at DESC")
      flash[:success] = "#{@spc_bets.count} Résultat(s) trouvé(s)."
    end
  end

  def cm_bets
    @class_gamers = "active"
    @gamer = User.find_by_id(params[:gamer_id])

    if @gamer.blank?
      flash[:error] = "Cet utilisateur n'existe pas"
      redirect_to gamers_path
    else
      @cm_bets = Cm.where("punter_id = '#{@gamer.uuid}' AND serial_number IS NOT NULL").order("created_at DESC")
    end
  end

  def list_cm_bets
    @games_menu_style = "current"
    @cm_game_menu_style = "this"

    @cm_bets = Cm.where("serial_number IS NOT NULL").order("created_at DESC")
  end

  def cm_winners
    @winners_menu_style = "current"
    @cm_winners_menu_style = "this"

    @cm_bets = Cm.where("bet_status = 'Gagnant' OR bet_status = 'Vainqueur en attente de paiement'").order("created_at DESC")
  end

  def export_cm_winners
    @cm_bets = Cm.where("bet_status = 'Gagnant' OR bet_status = 'Vainqueur en attente de paiement'").order("created_at DESC")

    send_data @cm_bets.to_csv, filename: "Gagnants-PMU-ALR-#{Date.today}.csv"
  end

  def export_cm_winners_on_hold
    @cm_bets = Cm.where("bet_status = 'Vainqueur en attente de paiement'").order("created_at DESC")

    send_data @cm_bets.to_csv, filename: "Gagnants-PMU-ALR-en-attente-de-paiement-#{Date.today}.csv"
  end

  def list_cm_bet_search
    @games_menu_style = "current"
    @cm_game_menu_style = "this"
    @begin_date = params[:begin_date]
    @end_date = params[:end_date]
    @status = params[:status_id]
    @min_amount = params[:min_amount]
    @max_amount = params[:max_amount]

    params[:begin_date] = @begin_date
    params[:end_date] = @end_date
    params[:status_id] = @status
    params[:min_amount] = @min_amount
    params[:max_amount] = @max_amount

    set_cm_search_params

    @cm_bets = Cm.where("#{@sql_begin_date} #{@sql_begin_date.blank? ? '' : 'AND'} #{@sql_end_date} #{@sql_end_date.blank? ? '' : 'AND'} #{@sql_status} #{@sql_status.blank? ? '' : 'AND'} #{@sql_min_amount} #{@sql_min_amount.blank? ? '' : 'AND'} #{@sql_max_amount} #{@sql_max_amount.blank? ? '' : 'AND'} serial_number IS NOT NULL").order("created_at DESC")
    flash[:success] = "#{@cm_bets.count} Résultat(s) trouvé(s)."

    if params[:commit] == "Exporter"
      send_data @cm_bets.to_csv, filename: "Parieurs-PMU-ALR-#{Date.today}.csv"
    end
  end

  def cm_bet_details
    @class_gamers = "active"
    @bet = Cm.find_by_id(params[:bet_id])
    if @bet.blank?
      flash[:error] = "Ce pari n'existe pas"
      redirect_to gamers_path
    else
      @gamer = User.find_by_uuid(@bet.punter_id)
    end
  end

  def cm_bet_search
    @class_gamers = "active"
    @gamer = User.find_by_uuid(params[:uuid])
    @begin_date = params[:begin_date]
    @end_date = params[:end_date]
    @status = params[:status_id]
    @min_amount = params[:min_amount]
    @max_amount = params[:max_amount]

    if @gamer.blank?
      redirect_to gamers_path
    else
      params[:begin_date] = @begin_date
      params[:end_date] = @end_date
      params[:status_id] = @status
      params[:min_amount] = @min_amount
      params[:max_amount] = @max_amount

      set_cm_search_params

      @cm_bets = Cm.where("#{@sql_begin_date} #{@sql_begin_date.blank? ? '' : 'AND'} #{@sql_end_date} #{@sql_end_date.blank? ? '' : 'AND'} #{@sql_status} #{@sql_status.blank? ? '' : 'AND'} #{@sql_min_amount} #{@sql_min_amount.blank? ? '' : 'AND'} #{@sql_max_amount} #{@sql_max_amount.blank? ? '' : 'AND'} punter_id = '#{@gamer.uuid}' AND serial_number IS NOT NULL").order("created_at DESC")
      flash[:success] = "#{@cm_bets.count} Résultat(s) trouvé(s)."
    end
  end

  def eppl_bets
    @class_gamers = "active"
    @gamer = User.find_by_id(params[:gamer_id])

    if @gamer.blank?
      flash[:error] = "Cet utilisateur n'existe pas"
      redirect_to gamers_path
    else
      @eppl_bets = Eppl.where("gamer_id = '#{@gamer.uuid}' AND error_code IS NULL AND bet_validated IS TRUE").order("created_at DESC")
    end
  end

  def list_eppl_bets
    @games_menu_style = "current"
    @eppl_game_menu_style = "this"

    @eppl_bets = Eppl.where("error_code IS NULL AND bet_validated IS TRUE").order("created_at DESC")
  end

  def list_eppl_bet_search
    @games_menu_style = "current"
    @eppl_game_menu_style = "this"
    @begin_date = params[:begin_date]
    @end_date = params[:end_date]
    @status = params[:status_id]
    @min_amount = params[:min_amount]
    @max_amount = params[:max_amount]

    params[:begin_date] = @begin_date
    params[:end_date] = @end_date
    params[:status_id] = @status
    params[:min_amount] = @min_amount
    params[:max_amount] = @max_amount

    set_eppl_search_params

    @eppl_bets = Eppl.where("#{@sql_begin_date} #{@sql_begin_date.blank? ? '' : 'AND'} #{@sql_end_date} #{@sql_end_date.blank? ? '' : 'AND'} #{@sql_status} #{@sql_status.blank? ? '' : 'AND'} #{@sql_min_amount} #{@sql_min_amount.blank? ? '' : 'AND'} #{@sql_max_amount} #{@sql_max_amount.blank? ? '' : 'AND'} error_code IS NULL AND bet_validated IS TRUE").order("created_at DESC")
    #@eppl_bets = Eppl.where("#{@sql_begin_date} #{@sql_begin_date.blank? ? '' : 'AND'} #{@sql_end_date} #{@sql_end_date.blank? ? '' : 'AND'} #{@sql_status} #{(!@sql_status.blank? && (!@sql_min_amount.blank? || !@sql_max_amount.blank?)) ? 'AND' : ''} #{@sql_min_amount} #{(!@sql_min_amount.blank? && !@sql_max_amount.blank?) ? 'AND' : ''} #{@sql_max_amount} bet_placed IS TRUE").order("created_at DESC")
    flash[:success] = "#{@eppl_bets.count} Résultat(s) trouvé(s)."

    if params[:commit] == "Exporter"
      send_data @eppl_bets.to_csv, filename: "Parieurs-Jeux-digitaux-#{Date.today}.csv"
    end
  end

  def eppl_bet_details
    @class_gamers = "active"
    @bet = Eppl.find_by_id(params[:bet_id])
    if @bet.blank?
      flash[:error] = "Ce pari n'existe pas"
      redirect_to gamers_path
    else
      @gamer = User.find_by_uuid(@bet.gamer_id)
    end
  end

  def eppl_bet_search
    @class_gamers = "active"
    @gamer = User.find_by_uuid(params[:uuid])
    @begin_date = params[:begin_date]
    @end_date = params[:end_date]
    @status = params[:status_id]
    @min_amount = params[:min_amount]
    @max_amount = params[:max_amount]

    if @gamer.blank?
      redirect_to gamers_path
    else
      params[:begin_date] = @begin_date
      params[:end_date] = @end_date
      params[:status_id] = @status
      params[:min_amount] = @min_amount
      params[:max_amount] = @max_amount

      set_eppl_search_params

      @eppl_bets = Eppl.where("#{@sql_begin_date} #{@sql_begin_date.blank? ? '' : 'AND'} #{@sql_end_date} #{@sql_end_date.blank? ? '' : 'AND'} #{@sql_status} #{@sql_status.blank? ? '' : 'AND'} #{@sql_min_amount} #{@sql_min_amount.blank? ? '' : 'AND'} #{@sql_max_amount} #{@sql_max_amount.blank? ? '' : 'AND'} gamer_id = '#{@gamer.uuid}' AND error_code IS NULL AND bet_validated IS TRUE").order("created_at DESC")
      flash[:success] = "#{@eppl_bets.count} Résultat(s) trouvé(s)."
    end
  end

  def loto_winners_on_hold
    @winners_on_hold_menu_style = "current"
    @loto_winner_on_hold_menu_style = "this"

    @loto_bets = AilLoto.where("bet_status = 'Vainqueur en attente de paiement'").order("created_at DESC")
  end

  def export_loto_winners_on_hold
    @loto_bets = AilLoto.where("bet_status = 'Vainqueur en attente de paiement'").order("created_at DESC")

    send_data @loto_bets.to_csv, filename: "Gagnants-LOTO-en-attente-de-paiement-#{Date.today}.csv"
  end

  def validate_on_hold_loto_winner
    @loto_bet = AilLoto.where("id = ? AND bet_status = 'Vainqueur en attente de paiement'", params[:bet_id]).first rescue nil

    if @loto_bet.blank?
      flash[:error] = "Ce pari n'existe pas"
      redirect_to :back
    else
      @loto_bet.update_attributes(bet_status: 'Gagnant', on_hold_winner_paid_at: DateTime.now)
      flash[:success] = "Le pari a été payé"
      redirect_to :back
    end
  end

  def pmu_plr_winners_on_hold
    @winners_on_hold_menu_style = "current"
    @pmu_plr_winner_on_hold_menu_style = "this"

    @pmu_plr_bets = AilPmu.where("bet_status = 'Vainqueur en attente de paiement'").order("created_at DESC")
  end

  def validate_on_hold_pmu_plr_winner
    @pmu_plr_bet = AilPmu.where("id = ? AND bet_status = 'Vainqueur en attente de paiement'", params[:bet_id]).first rescue nil

    if @pmu_plr_bet.blank?
      flash[:error] = "Ce pari n'existe pas"
      redirect_to :back
    else
      @pmu_plr_bet.update_attributes(bet_status: 'Gagnant', on_hold_winner_paid_at: DateTime.now)
      flash[:success] = "Le pari a été payé"
      redirect_to :back
    end
  end

  def spc_winners_on_hold
    @winners_on_hold_menu_style = "current"
    @spc_winner_on_hold_menu_style = "this"

    @spc_bets = Bet.where("bet_status = 'Vainqueur en attente de paiement'").order("created_at DESC")
  end

  def validate_on_hold_spc_winner
    @spc_bet = Bet.where("id = ? AND bet_status = 'Vainqueur en attente de paiement'", params[:bet_id]).first rescue nil

    if @spc_bet.blank?
      flash[:error] = "Ce pari n'existe pas"
      redirect_to :back
    else
      @spc_bet.update_attributes(bet_status: 'Gagnant', on_hold_winner_paid_at: DateTime.now)
      flash[:success] = "Le pari a été payé"
      redirect_to :back
    end
  end

  def cm_winners_on_hold
    @winners_on_hold_menu_style = "current"
    @cm_winner_on_hold_menu_style = "this"

    @cm_bets = Cm.where("bet_status = 'Vainqueur en attente de paiement'").order("created_at DESC")
  end

  def validate_on_hold_cm_winner
    @cm_bet = Cm.where("id = ? AND bet_status = 'Vainqueur en attente de paiement'", params[:bet_id]).first rescue nil

    if @cm_bet.blank?
      flash[:error] = "Ce pari n'existe pas"
      redirect_to :back
    else
      @cm_bet.update_attributes(bet_status: 'Gagnant', on_hold_winner_paid_at: DateTime.now)
      flash[:success] = "Le pari a été payé"
      redirect_to :back
    end
  end

  private
    def set_loto_search_params
      @sql_begin_date = ""
      @sql_end_date = ""
      @sql_status = ""
      @sql_min_amount = ""
      @sql_max_amount = ""

      unless @begin_date.blank?
        @sql_begin_date = "created_at::date >= '#{@begin_date}'"
      end
      unless @end_date.blank?
        @sql_end_date = "created_at::date <= '#{@end_date}'"
      end
      unless @status.blank?
        @sql_status = "bet_status = '#{@status}'"
      end
      unless @min_amount.blank?
        @sql_min_amount = "CAST((COALESCE(earning_amount,NULL)) AS INTEGER) >= #{@min_amount.to_i}"
      end
      unless @max_amount.blank?
        @sql_max_amount = "CAST((COALESCE(earning_amount,NULL)) AS INTEGER) <= #{@max_amount.to_i}"
      end
    end

    def set_pmu_plr_search_params
      @sql_begin_date = ""
      @sql_end_date = ""
      @sql_status = ""
      @sql_min_amount = ""
      @sql_max_amount = ""

      unless @begin_date.blank?
        @sql_begin_date = "created_at::date >= '#{@begin_date}'"
      end
      unless @end_date.blank?
        @sql_end_date = "created_at::date <= '#{@end_date}'"
      end
      unless @status.blank?
        @sql_status = "bet_status = '#{@status}'"
      end
      unless @min_amount.blank?
        @sql_min_amount = "CAST((COALESCE(earning_amount,NULL)) AS INTEGER) >= #{@min_amount.to_i}"
      end
      unless @max_amount.blank?
        @sql_max_amount = "CAST((COALESCE(earning_amount,NULL)) AS INTEGER) <= #{@max_amount.to_i}"
      end
    end

    def set_spc_search_params
      @sql_begin_date = ""
      @sql_end_date = ""
      @sql_status = ""
      @sql_min_amount = ""
      @sql_max_amount = ""

      unless @begin_date.blank?
        @sql_begin_date = "created_at::date >= '#{@begin_date}'"
      end
      unless @end_date.blank?
        @sql_end_date = "created_at::date <= '#{@end_date}'"
      end
      unless @status.blank?
        @sql_status = "bet_status = '#{@status}'"
      end
      unless @min_amount.blank?
        @sql_min_amount = "CAST((COALESCE(win_amount,NULL)) AS INTEGER) >= #{@min_amount.to_i}"
      end
      unless @max_amount.blank?
        @sql_max_amount = "CAST((COALESCE(win_amount,NULL)) AS INTEGER) <= #{@max_amount.to_i}"
      end
    end

    def set_cm_search_params
      @sql_begin_date = ""
      @sql_end_date = ""
      @sql_status = ""
      @sql_min_amount = ""
      @sql_max_amount = ""

      unless @begin_date.blank?
        @sql_begin_date = "created_at::date >= '#{@begin_date}'"
      end
      unless @end_date.blank?
        @sql_end_date = "created_at::date <= '#{@end_date}'"
      end
      unless @status.blank?
        @sql_status = "bet_status = '#{@status}'"
      end
      unless @min_amount.blank?
        @sql_min_amount = "CAST((COALESCE(win_amount,NULL)) AS INTEGER) >= #{@min_amount.to_i}"
      end
      unless @max_amount.blank?
        @sql_max_amount = "CAST((COALESCE(win_amount,NULL)) AS INTEGER) <= #{@max_amount.to_i}"
      end
    end

    def set_eppl_search_params
      @sql_begin_date = ""
      @sql_end_date = ""
      @sql_status = ""
      @sql_min_amount = ""
      @sql_max_amount = ""

      unless @begin_date.blank?
        @sql_begin_date = "created_at::date >= '#{@begin_date}'"
      end
      unless @end_date.blank?
        @sql_end_date = "created_at::date <= '#{@end_date}'"
      end
      unless @status.blank?
        @sql_status = "operation = '#{@status}'"
      end
      unless @min_amount.blank?
        @sql_min_amount = "CAST((COALESCE(transaction_amount,NULL)) AS INTEGER) >= #{@min_amount.to_i}"
      end
      unless @max_amount.blank?
        @sql_max_amount = "CAST((COALESCE(transaction_amount,NULL)) AS INTEGER) <= #{@max_amount.to_i}"
      end
    end

end
