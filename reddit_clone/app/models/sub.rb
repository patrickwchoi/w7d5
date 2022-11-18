# == Schema Information
#
# Table name: subs
#
#  id           :bigint           not null, primary key
#  title        :string           not null
#  description  :text
#  moderator_id :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Sub < ApplicationRecord
    validates :title, presence: true

    has_many :posts,
        foreign_key: :sub_id,
        class_name: :Post,
        dependent: :destroy,
        inverse_of: :sub

    belongs_to :moderator,
        foreign_key: :moderator_id,
        class_name: :User
end
