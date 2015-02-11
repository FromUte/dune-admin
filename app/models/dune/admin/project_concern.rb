module Dune::Admin::ProjectConcern
  extend ActiveSupport::Concern

  included do
    scope :by_progress, ->(progress) do
      projects = select { |project|
        project.project_total.pledged >= project.goal * (progress / 100.0)
      }
      where(id: projects)
    end

    scope :by_user_email, ->(email) do
      joins('JOIN users as u ON u.id = projects.user_id').
        where("u.email = ?", email)
    end

    scope :by_category_id, ->(id) do
      where(category_id: id)
    end

    scope :name_contains, ->(term) do
      where("unaccent(upper(name)) LIKE ('%'||unaccent(upper(?))||'%')", term)
    end

    scope :goal_between, ->(starts_at, ends_at) do
      where("goal BETWEEN ? AND ?", starts_at, ends_at)
    end

    [:between_created_at, :between_expires_at, :between_online_date, :between_updated_at].each do |name|
      define_singleton_method name do |starts_at, ends_at|
        between_dates name.to_s.gsub('between_',''), starts_at, ends_at
      end
    end

    private
    def self.between_dates(attribute, starts_at, ends_at)
      return all unless starts_at.present? && ends_at.present?
      where("projects.#{attribute}::date between to_date(?, 'dd/mm/yyyy') and to_date(?, 'dd/mm/yyyy')", starts_at, ends_at)
    end
  end
end
