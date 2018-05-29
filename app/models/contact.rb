class Contact < ApplicationRecord
  belongs_to :group, optional: true

  validates :name, presence: { message: "名字不能为空" }
end
