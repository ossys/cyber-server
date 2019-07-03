# frozen_string_literal: true

Fabricator(:user) do
  id 1
  email "demo23@email.com"
  password "pass"
  #password_digest "$2a$12$g//bf9lAnNEL2aykpAkLY.tgRzSNjibwVjKLCoaLYPy58ZA2HqIIO"
  created_at "2019-07-01 13:48:28"
  updated_at "2019-07-01 13:48:28"
end
