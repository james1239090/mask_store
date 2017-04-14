OffsitePayments::Integrations::Pay2go.setup do |pay2go|
  # You have to apply credential below by yourself.
  pay2go.merchant_id = ENV['pay2go_merchant_id']
  pay2go.hash_key    = ENV['pay2go_hash_key']
  pay2go.hash_iv     = ENV['pay2go_hash_iv']
end


