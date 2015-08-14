class Player < ActiveRecord::Base
 
  after_initialize :init

  validates :first_name, :last_name, length: { maximum: 30 }, allow_blank: true
  validates :sport, presence: true, inclusion: { in: %w( baseball basketball football ), message: "'%{value}' is not a sport that we support right now." }
  validates :age, numericality: { greater_than: 0, less_than: 100}, allow_blank: true 
  validate :presence_of_a_name # Invalidate when neither a firstname or lastname is given
  # Note / Todo: The folliwing validation is due to the fact that the CBS API returns some positions 
  # that don't apply to individual players. Normally this should probably be a whitelist rather than a blacklist.
  validates :position, exclusion: { in: %w( PS D ST TQB DST )}

  def init
    self.first_name ||= ""
    self.last_name ||= ""
    self.age ||= nil
    self.name_brief ||= self.create_name_brief
  end

  # Ensure names are capitalized
  def first_name=(s)
    write_attribute(:first_name, s.to_s.capitalize)
  end

  def last_name=(s)
    write_attribute(:last_name, s.to_s.capitalize)
  end

  # Return a '+' sign if result is positive. Return empty string if nil
  def formatted_avg_pos_age_diff
    if self.avg_pos_age_diff.present?
      return self.avg_pos_age_diff > 0 ? "+#{self.avg_pos_age_diff.round(0)}" : self.avg_pos_age_diff.round(0).to_s
    else
      return ""
    end
  end

  def create_name_brief
    if self.first_name.present? && self.last_name.present?
      case self.sport
        when 'baseball'
          return "#{self.first_name[0]}. #{self.last_name[0]}." 
        when 'basketball'
          return "#{self.first_name} #{self.last_name[0]}."
        when 'football'
          return "#{self.first_name[0]}. #{self.last_name}"
        end
    end
  end

  private

  def presence_of_a_name
    if self.first_name.blank? && self.last_name.blank?
      errors.add(:player, "must at least have a first or last name")
    end
  end

end
