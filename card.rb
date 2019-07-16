require 'json'

 # TODO: 
    # - check inputs
    # - method to update output

module Card
  def self.authorized?(account_data, latest_approved, current_transaction)
    account_parse = JSON.parse(account_data)
    # latest_parse = JSON.parse(latest_approved)
    current_parse = JSON.parse(current_transaction)

    output = {
      'approved' => 'True',
      'newLimit' => '0',
      'deniedReasons' => []
    }

    if abovelimit?(account_parse["limit"], current_parse["amount"])
      output['deniedReasons'].push('Above Limit')
      output['approved'] = 'false'
    else
      if output['approved'] == 'True'
        output['newLimit'] = account_parse["limit"].to_i - current_parse["amount"].to_i 
      end
    end

    if cardblocked?(account_parse["cardIsActive"])
      output['deniedReasons'].push('Card Blocked')
      output['approved'] = 'False'
    else
      if output['approved'] == 'True'
        output['newLimit'] = account_parse["limit"].to_i  - current_parse["amount"].to_i 
      end
    end
    return output
  end
  def self.abovelimit?(limit, amount)
    return amount.to_i > limit.to_i
  end
  def self.cardblocked?(status)
    return status == 'False'
  end
end

if $PROGRAM_NAME == __FILE__
  account_data_json = '{"cardIsActive": "False","limit": "1000","blacklist": [ "João" ],"isWhitelisted": "False"}'
  latest_approved = '{"merchant": "Zezinho", "amount": "300", "time": "2019-07-11 17:37:22 -0300"}'
  transaction = '{"merchant": "Zezinho", "amount": "400", "time": "2019-07-14 17:37:22 -0300"}'
  puts Card.authorized?(account_data_json, latest_approved, transaction)
end
