module Gomisa
  class AdjustmentIndexService
    attr_reader :reason_params, :range_params
    attr_reader :adjustments

    def initialize(reason_params, range_params)
      @reason_params = reason_params
      @range_params = range_params
    end

    def call
      @adjustments = filter_adjustments(parse_reason(reason_params), range_params)
    end


    private

    def filter_adjustments(reason, range)
      adjustments = if anyway?
                      Adjustment.all
                    else
                      Adjustment.where(reason: reason)
                    end

      from_to_date_filter(adjustments, range)
    end

    def from_to_date_filter(adjustments, date_range)
      adjustments.where(exported_at: date_range)
    end

    def anyway?
      reason_params == 'All'
    end

    def parse_reason(reason)
      {
        inbound: 'Nhập hàng (From Korea)',
        rebound: 'Hủy đơn hàng (Order Cancel)',
        outbound: 'Xuất hàng (Orders)'
      }[reason.to_s.to_sym] || 'All'
    end
  end
end
