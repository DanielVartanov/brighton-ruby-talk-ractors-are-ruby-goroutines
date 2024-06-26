






@bank_account = 0

10.times.map do
  Thread.new do
    1_000_000.times do
      value = @bank_account
      value = value + 1
      @bank_account = value
    end
  end
end.each(&:join)

print @bank_account
puts @bank_account == 10_000_000 ?
       "\e[32m ALL CORRECT \e[0m" :
       "\e[31m RACE CONDITION! \e[0m"
