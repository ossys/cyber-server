class EnrollRequest < Dry::Validation::Contract
  params do
    required(:enroll_secret).filled(:string)
    required(:host_identifier).filled(:string)
    required(:host_details).hash do
      required(:os_version).hash do
        required(:major).filled(:string)
      end
      required(:osquery_info).hash do
        required(:computer_name).filled(:string)
      end
      required(:system_info).hash do
        required(:hostname).filled(:string)
      end
    end
  end
end
