class User < ApplicationRecord
  self.inheritance_column = :role

  USER_ROLES = [ 'student', 'mentor' ].freeze

  validates :first_name,
            :email,
            presence: true

  validates :email,
            uniqueness: true,
            format: {
              with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
            }

  class << self
    # Please refer to this
    # https://gist.github.com/dr-click/4c1a935bb42633b079d06909af6c12e2

    def set_sti_class(type_name)
      role_types[type_name] or super
    end

    def sti_name
      role_types.invert[self]
    end

    alias_method :find_sti_class, :set_sti_class

    def role_types
      result = {}
      USER_ROLES.each do |role|
        result[role] = role.classify.constantize
      end
      result
    end
  end

end
