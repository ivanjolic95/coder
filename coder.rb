require 'optparse'

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

options = {}

OptionParser.new do |opts|
  opts.banner = "Usage: coder.rb [options]"

  opts.on("-t", "--text TEXT", String, "Input text") do |t|
    if t or options[:file]
      options[:text] = t
    else
      puts opts.banner
    end
  end

  opts.on("-f", "--file FILENAME", String, "Input file") do |f|
    if f or options[:text]
      options[:file] = f
    else
      puts opts.banner
    end
  end

  opts.on("-p", "--password PASSWORD", String, "Password") do |p|
    if p
      options[:password] = p
    else
      puts opts.banner
    end
  end

  opts.on("-o", "--output FILENAME", String, "Output file") do |o|
    if o
      options[:output] = o
    end
  end
end.parse!

coder = Coder.new

if (options[:file] or options[:text]) and options[:password]
  if options[:file]
    input = File.binread(options[:file])
  else
    input = options[:text]
  end

  coder.text = input
  coder.password = options[:password]

  coder.apply_password

  if options[:output]
    puts "You can find the result in #{options[:output]}"
    File.binwrite(options[:output], coder.text)
  else
    puts coder.text
  end
end
