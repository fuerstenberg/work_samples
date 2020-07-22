class ApplicationController < ActionController::Base

  rescue_from "AccessGranted::AccessDenied" do |exception|
    if user_signed_in?
      redirect_to root_url, alert: 'Du hast nicht die benötigten Zugriffsrechte!'
    else
      redirect_to destroy_user_session_url, alert: 'Du hast nicht die benötigten Zugriffsrechte! Du bist nicht angemeldet!'
    end
  end

  include Concerns::Redirects

  include Concerns::ControllerImpressionsCounter
  include Concerns::SetObjects
  include PublicActivity::StoreController

  protect_from_forgery with: :exception

  around_action :redirect_document_not_found_to_search, only: :show

  before_filter :set_locale
  before_action :authenticate_user!
  before_filter :find_customer_by_customer_token
  before_filter :provide_general_js_data_via_gon
  before_filter :provide_ride_requests_via_gon
  before_filter :provide_users_online_via_gon
  before_filter :update_sanitized_params, if: :devise_controller?

  after_filter :current_user_is_online!
  after_filter :current_user_update_location_by_ip

  helper_method :admin?
  helper_method :gon
  helper_method :last_visited_users
  helper_method :user_scope?

  serialization_scope :view_context

  private

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || root_path
  end

  def update_sanitized_params
    devise_parameter_sanitizer.permit :sign_up, keys: [:name, :terms_of_service, :email, :password, :password_confirmation]
  end

  def save_last_visited_user(user)
    return if @user == current_user
    cookies[:last_visited_user_ids] = last_visited_user_ids.unshift(user.id).uniq[0,5].join(',')
  end

  def last_visited_user_ids
    cookies[:last_visited_user_ids].split(',') rescue []
  end

  def last_visited_users
    User.where(id: last_visited_user_ids).order(:name)
  end

  def set_locale
    I18n.locale = :de
    Stringex::Localization.locale = :de
  end

  def user_scope?
    !!params["user_scope"]
  end

  def admin?
    user_signed_in? and current_user.admin?
  end

  def current_user_is_online!
    current_user.is_online! if user_signed_in?
  end

  def find_customer_by_customer_token
    if params[:ct] and @customer = Customer.find_by_token(params[:ct])
      session[:customer_token] = @customer.token
    elsif session[:customer_token]
      @customer = Customer.find_by_token session[:customer_token]
    end
  end

  def provide_general_js_data_via_gon
    gon.push({
      currentUser:           (user_signed_in? ? UserSerializer.new(current_user).serializable_hash : false),
      facebookApplicationId: Rails.application.secrets.facebook_key,
      lastRequestMethod:     request.method
    })
  end

  def provide_ride_requests_via_gon
    if user_signed_in?
      gon.push({
        # rideRequests:    ActiveModel::ArraySerializer.new(current_user.ride_requests.not_deleted.upcoming, each_serializer: RideRequestSerializer),
        drivingStyles:   User.favorite_driving_style.options.to_h,
        rideRequestDays: (Date.today..(Date.today+4.days)).map
      })
    end
  end

  def provide_users_online_via_gon
    gon.push({ onlineUserIds: User.online.map(&:id).map(&:to_s) })
  end

  def redirect_document_not_found_to_search
    yield
  rescue Mongoid::Errors::DocumentNotFound
    redirect_to searches_url(search: { query: (params[:id] || params[:tag_id]).gsub('-', ' ') }), status: 301
  end

  def current_user_update_location_by_ip
    if user_signed_in?
      current_user.update_from_request(request)
    end
  end

end
