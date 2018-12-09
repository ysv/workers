# frozen_string_literal: true

class LotCreatedConsumer
  def call(message)
    lot_obj = find_lot(message)
    return unless lot_obj

    geth_service = SmartContractService.new
    geth_service.add_new_lot(
      initial_price: lot_obj.start_price,
      bid_increment: lot_obj.start_price / 5
    ).tap do |txid|
      Rails.logger.info { "Lot creation txid: #{txid}" }
    end

    lot_obj.update(state: :published)
  end

  private

  def find_lot(message)
    Rails.logger.info { "LotCreatedConsumer receive message #{message}" }

    lot_id = message[:lot_id] || message['lot_id']
    unless lot_id
      Rails.logger.warn { "LotCreatedConsumer can't process message #{message}" }
      return
    end

    lot_obj = Lot.find_by_id(lot_id)
    unless lot_obj
      Rails.logger.warn { "Skipped lot with id: #{lot_id}. Doesn't exist in db" }
      return
    end

    unless lot_obj.state == 'created'
      Rails.logger.warn { "Skipped lot with id: #{lot_id}. Lot state != created" }
      return
    end
    lot_obj
  end
end
