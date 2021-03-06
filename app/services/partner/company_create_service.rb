module Partner

  # @param
  #
  # {
  #   company: {
  #     name,
  #     description
  #   },
  #   owner_id
  # }
  class CompanyCreateService
    attr_reader :params, :company, :membership

    def initialize(params)
      @params = params
      @company = Company.new(company_param)
      @membership = Membership.new(membership_param)
    end

    def save
      save_company && set_ownership
    end

    private

    def save_company
      company.save
    end

    def set_ownership
      membership.role = 'owner'
      membership.company_id = company.id
      membership.accepted = true
      membership.save
    end

    def company_param
      params.require(:company).permit(:name, :description)
    end

    def membership_param
      params.require(:membership).permit(:manager_id, :role)
    end
  end
end
