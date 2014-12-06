class Coder
  attr_accessor :text, :password

  def apply_password
    pass_pos = 0
    @text.length.times do |text_pos|
      pass_pos = (pass_pos == @password.length) ? 0 : pass_pos
      text_char = @text[text_pos].ord
      pass_char = @password[pass_pos].ord
      text_char ^= pass_char
      @text[text_pos] = text_char.chr
      pass_pos += 1
    end
  end
end

coder = Coder.new

puts "Please enter the text you need to protect: "
coder.text = gets

puts "Great! Now enter the password:"
coder.password = gets

coder.apply_password

puts "And the result is:"
puts coder.text

puts "If we apply the password again:"
coder.apply_password
puts coder.text
