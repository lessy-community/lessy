json.ignore_nil!
json.registration_disabled !Flipper.enabled?(:feature_registration)
json.tos_version TermsOfService.current&.version
