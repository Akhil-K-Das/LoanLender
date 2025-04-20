require 'sidekiq/cron/job'

Sidekiq::Cron::Job.load_from_hash!({
  'interest_calculator' => {
    'class' => 'InterestCalculatorJob',
    'cron' => '*/5 * * * *',
    'queue' => 'default'
  }
})
