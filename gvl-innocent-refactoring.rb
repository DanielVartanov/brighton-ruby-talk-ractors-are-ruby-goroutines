def read_from_bank_account
  @bank_account
end

def write_to_bank_account(value)
  @bank_account = value
end

@bank_account = 0

10.times.map do
  Thread.new do
    1_000_000.times do
      value = read_from_bank_account
            # ^^^^^^^^^^^^^^^^^^^^^^ Extracted method
      value = value + 1
      @bank_account = write_to_bank_account(value)
                    # ^^^^^^^^^^^^^^^^^^^^^ Extracted method
    end
  end
end.each(&:join)

print @bank_account
puts @bank_account == 10_000_000 ?
       "\e[32m ALL CORRECT \e[0m" :
       "\e[31m RACE CONDITION! \e[0m"
