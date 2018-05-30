class Contact < ApplicationRecord
  belongs_to :group, optional: true

  validates :name, presence: { message: "名字不能为空" }

  scope :search, -> (term) do
      where('LOWER(name) LIKE :term', term: "%#{term.downcase}%") if term.present?
  end 

  scope :by_group, -> (group_id) { where(group_id: group_id) if group_id.present? }
end
