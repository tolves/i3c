class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  connects_to database: { writing: :primary, reading: :primary_replica }
  has_paper_trail

  def self.history
    PaperTrail::Version.where("item_type = ?", self).order(created_at: :desc)
  end
end