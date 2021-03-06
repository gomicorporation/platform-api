module Partner
  class ManagersController < BaseController
    before_action :authenticate_request!, only: [:index, :show]
    before_action :set_manager, only: :show

    def index
      manager_records = if params[:format] == 'json' && params[:email]
                          Manager.where('email LIKE ?', "%#{params[:email]}%")
                        else
                          Manager.includes(include_tables).where(query_param)
                        end

      @managers = decorator_class.decorate_collection(manager_records)
      render json: @managers
    end

    def show
      render json: @manager
    end

    # 이메일로 초대장을 보내고, 신규 매니저를 생성한다.
    def create
      @manager = Manager.new(manager_params)

      # set token (same with his password which is Devise friendly_token)
      # send email

      if @manager.save
        render json: @manager, status: :created
      else
        ap @manager.errors
        render json: @manager.errors, status: :unprocessable_entity
      end
    end

    protected

    def default_decorator_name
      'Users::Managers::DefaultDecorator'
    end

    def set_manager
      manager_record = Manager.includes(include_tables).find(params[:id])
      @manager = decorator_class.decorate(manager_record)
    end

    def include_tables
      [memberships: :company]
    end

    def query_param
      params.permit(:id, *Manager.attribute_names)
    end

    # => params[:manager]
    #
    # - name                  : optional
    # - email                 : required
    # - password              : optional
    # - password_confirmation : optional
    # - invite_confirmation_token: optional
    #
    def manager_params
      params[:manager][:name] ||= "user#{Manager.auto_increment_value}"

      # unless params[:manager][:password]
      #   token = Devise.friendly_token
      #   params[:manager][:password] ||= token
      #   params[:manager][:password_confirmation] ||= token
      #   params[:manager][:invite_confirmation_token] ||= token
      # end

      params.require(:manager).permit(:name, :email, :password, :password_confirmation, :invite_confirmation_token)
    end
  end
end
