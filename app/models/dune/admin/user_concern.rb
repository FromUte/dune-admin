module Dune::Admin::UserConcern
  extend ActiveSupport::Concern

  included do
    scope :by_email, ->(email){ where('email ~* ?', email) }
    scope :by_name, ->(name){ where('users.name ~* ?', name) }
    scope :by_id, ->(id){ where(id: id) }
    scope :by_key, ->(key){ where('EXISTS(SELECT true FROM contributions WHERE contributions.user_id = users.id AND contributions.key ~* ?)', key) }
    scope :has_credits, -> { joins(:user_total).where('user_totals.credits > 0') }
    scope :order_by, ->(sort_field){ order(sort_field) }
  end
end

