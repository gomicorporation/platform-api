# == Schema Information
#
# Table name: memberships
#
#  id         :bigint           not null, primary key
#  accepted   :boolean          default(FALSE), not null
#  role       :integer          default("member"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint           not null
#  manager_id :bigint           not null
#
# Indexes
#
#  index_memberships_on_company_id  (company_id)
#  index_memberships_on_manager_id  (manager_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (manager_id => users.id)
#
require 'test_helper'

class MembershipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
