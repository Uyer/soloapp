if Rails.env.production?
  Rails.configuration.stripe = {
    publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
    secret_key: ENV['STRIPE_SECRET_KEY']
  }
else
  Rails.configuration.stripe = {
    publishable_key: 'pk_test_XDThmG7sez4uHod7GwvvAXyF',
    secret_key: 'sk_test_iwgO4vidEhjDbzY8tgNgzatC'
  }
end
Stripe.api_key = Rails.configuration.stripe[:secret_key]