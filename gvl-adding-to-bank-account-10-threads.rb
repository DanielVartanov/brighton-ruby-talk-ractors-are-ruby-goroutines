






@bank_account = 0

10.times.map do
  Thread.new do
    1_000_000.times do
      @bank_account += 1
    end
  end
end.each(&:join)
