class User < ApplicationRecord
  # encrypts :last_name
  # encrypts :last_name, deterministic: true,
  # encrypts :last_name, deterministic: true,  downcase: true
  # encrypts :last_name, deterministic: true,  ignore_case: true

  scope :some_complex_scope, -> { where("SELECT true FROM pg_sleep(1)").limit(10) }

  # has_one_attached :profile_pic
  has_one_attached :profile_pic do |attachable|
    attachable.variant :thumb, resize: "10x10"
  end

  has_one_attached :profile_intro

  def all_users_and_emails_async
    users = User.some_complex_scope.load_async
    emails = Email.some_complex_scope.load_async
  end

  def all_users_and_emails_sync
    users = User.some_complex_scope
    emails = Email.some_complex_scope
  end

  def try_sole
    User.find_sole_by(last_name: 'Jadhav')

    User.where(last_name: 'Jadhav').sole
  end
end