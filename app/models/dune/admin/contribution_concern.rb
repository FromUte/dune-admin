module Dune::Admin::ContributionConcern
  extend ActiveSupport::Concern

  included do
    scope :by_id, ->(id) { where(id: id) }
    scope :by_key, ->(key) { where(key: key) }
    scope :by_user_id, ->(user_id) { where(user_id: user_id) }
    scope :user_name_contains, ->(term) { joins(:user).where("unaccent(upper(users.name)) LIKE ('%'||unaccent(upper(?))||'%')", term) }
    scope :user_email_contains, ->(term) { joins(:user).where("unaccent(upper(users.email)) LIKE ('%'||unaccent(upper(?))||'%')", term) }
    scope :payer_email_contains, ->(term) { where("unaccent(upper(payer_email)) LIKE ('%'||unaccent(upper(?))||'%')", term) }
    scope :project_name_contains, ->(term) { joins(:project).where("unaccent(upper(projects.name)) LIKE ('%'||unaccent(upper(?))||'%')", term) }

    def self.between_values(start_at, ends_at)
      return all unless start_at.present? && ends_at.present?
      where("value between ? and ?", start_at, ends_at)
    end

    def change_reward!(reward)
      self.reward_id = reward
      self.save
    end
  end
end
