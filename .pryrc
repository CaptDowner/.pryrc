#Reformat Prompt
Pry.config.theme = "tomorrow-night"
# Other good looking pry-themes:
# "vividchalk", "railscasts", "github", "solarized"
# "pry-zealand-16", "tomorrow", "pry-modern", "monokai"
require 'pry'

Pry.config.prompt = proc do |obj, level, _|
  prompt = ""
  prompt << "#{Rails.version}@" if defined?(Rails)
  prompt << "#{RUBY_VERSION}"
  "#{prompt} (#{obj})> "
end

# Reformat Exception
Pry.config.exception_handler = proc do |output, exception, _|
  output.puts "\e[31m#{exception.class}: #{exception.message}"
  output.puts "from #{exception.backtrace.first}\e[0m"
end

# Rails
if defined?(Rails)
  begin
    require "rails/console/app"
    require "rails/console/helpers"
  rescue LoadError => e
    require "console_app"
    require "console_with_helpers"
  end
end

if defined?(PryDebugger)
  Pry.commands.alias_command 'c',  'continue'
  Pry.commands.alias_command 's',  'step'
  Pry.commands.alias_command 'n',  'next'
  Pry.commands.alias_command 'f',  'finish'
  Pry.commands.alias_command 'ss', 'show-source'
end

# ===================
# Custom Pry aliases
# ===================
# Where am I?
Pry.config.commands.alias_command 'w', 'whereami'
# Clear Screen
Pry.config.commands.alias_command '.cls', '.clear'

# Return only the methods not present on basic objects
class Object
  def ims
    (self.methods - Object.instance_methods).sort
  end
end

# load and execute a Ruby source file
def fl(fn)
   fn += '.rb' unless fn =~ /\.rb/
   @@recent = fn
   load "#{fn}"
end

# reload and excute the most recently loaded ruby source file
def rl 
  fl(@@recent)
end

# display only filenames in multiple column format
def lc
  op = %x{ ls -aC }
  op.gsub!('\t','\n')
  puts op
end

# List all files in filename order
def lsa
  puts %x{ls -la}.split("\n")
end

# list all files by size from smallest to largest
def lss
  puts %x{ls -la -S -r}.split("\n")
end

# list only directories
def ld
  puts %x{ls -la | egrep "^d"}
end

# list all files by date
def lsd
  puts %x{ls -la --sort=t -r -p}
end

# list only filenames, one per line, in alpha order
def lf
   puts %x(ls -aF)
end

# print (current) working directory
def pwd
  %x{pwd}.rstrip
end

# list all installed gems
def glist
  puts %x{ gem list }
end

# list gems matching search parameter
def gl2(str)
  puts %x{ gem list | sort | grep #{str} }
end

# display execution timing
def time(&b)
  require 'benchmark'
  res = nil
  timing = Benchmark.measure do
     res = yield
  end
  puts "Using yield, it took:     user       system     total       real"
  puts "                      #{timing}"
  res
end

# display which computer is in use
def loc
  pc=%x{ cat /var/www/html/location.txt }
  print pc
end

# display current PATH
def path
  %x{ echo $PATH }
end

# display process list
def pss
  op = %x{ ps --context ax }
  puts op
end

# find installed RPM, where f = string|regexp
def rqa(f)
  # if f is a string, convert it to a regexp
  if(f.class == String)
    f = Regexp.new f
  end
  # output list of .rpm files matching the regexp
  ((%x{rpm -qa | sort}).split("\n").each.grep f).each {|m| puts m }
end

# show the system date and time
def dt
  puts %x{date}
end

# list current startup info for services
def chk
  puts %x{/sbin/chkconfig --list}
end

# list all pci devices
def lpci
  puts %x{ lspci }
end

# list all usb devices
def lusb
  puts %x{ lsusb }
end

# show location, current ip(s) and network addresses
def sip
  # you must have a text file named "location.txt"
  # which should identify your machine in a unique way
  # I include a computer name, ip address, and email in mine

  if(Dir.entries('/var/www/html/').detect {|f| f.match /^location.txt/})
    f = File.open("/var/www/html/location.txt","r")
      f.each_byte do |i|
        print i.chr
      end
    f.close
  end
  print %x(ifconfig)
end

# show methods defined in .pryrc
def pm
  res=[]
  save_comment=String.new
  data = %x{ cat ~/.pryrc }
  str_arr = data.split("\n")

  puts "Pry custom commands defined in .pryrc:"
  counter=0

  while(str_arr[counter] != nil)
    # Ruby 1.9 returns an ordinal rather than a character, so...
    if(str_arr[counter][0] == "#"  || str_arr[counter][0] == 35) then
      save_comment = str_arr[counter]
    elsif(str_arr[counter].index("def") == 0) then
      m = str_arr[counter].gsub("def ","")
      m.chomp

      # output so columns are aligned
      if(m.length < 8) then
        res << (m + "\t   " + save_comment + "\n")
      else
        res << (m + "   " + save_comment + "\n")
      end

      m = ""
      save_comment = ""
    end
    counter += 1
  end
  res.sort!
  0.upto(counter) do |x|
    print res[x] 
  end

end

# display text file contents
def cat(f)
#  op = %x{cat #{f}}
  puts %x{cat #{f}}
end

pm

=begin

Pry categories of Help:
Help
Context
Editing
Introspection
Gems
Commands
Aliases
Input and Output
Misc
Navigating Pry
pry-debugger
pry-docmore
pry-rescue
pry-stack_explorer
pry-theme

Typing 'help <category name>' will give you pry command summaries 
related to a specific category.

Within pry, type 'help' and you will get this:

Help
  help               Show a list of commands or information about a specific command

Context
  cd                 Move into a new context (object or scope).
  find-method        Recursively search for a method within a Class/Module or the current namespace.
  ls                 Show the list of vars and methods in the current scope.
  pry-backtrace      Show the backtrace for the Pry session.
  raise-up           Raise an exception out of the current pry instance.
  reset              Reset the REPL to a clean state.
  whereami           Show code surrounding the current context.
  wtf?               Show the backtrace of the most recent exception.

Editing
  !                  Clear the input buffer.
  amend-line         Amend a line of input in multi-line mode.
  edit               Invoke the default editor on a file.
  hist               Show and replay Readline history.
  play               Playback a string variable or a method or a file as input.
  show-input         Show the contents of the input buffer for the current multi-line expression.

Introspection
  ri                 View ri documentation.
  show-source        Show the source for a method or class.
  stat               View method information and set _file_ and _dir_ locals.

Gems
  gem-cd             Change working directory to specified gem's directory.
  gem-install        Install a gem and refresh the gem cache.
  gem-list           List and search installed gems.
  gem-open           Opens the working directory of the gem in your editor

Commands
  import-set         Import a Pry command set.
  install-command    Install a disabled command.

Aliases
  !!!                Alias for `exit-program`
  !!@                Alias for `exit-all`
  $                  Alias for `show-source`
  .cls               Alias for `.clear`
  ?                  Alias for `show-doc`
  breakpoint         Alias for `break`
  breaks             Alias for `breakpoints`
  c                  Alias for `continue`
 clipit             Alias for `gist --clip`
  f                  Alias for `finish`
  file-mode          Alias for `shell-mode`
  history            Alias for `hist`
  jist               Alias for `gist`
  n                  Alias for `next`
  quit               Alias for `exit`
  quit-program       Alias for `exit-program`
  reload-method      Alias for `reload-code`
  s                  Alias for `step`
  show-method        Alias for `show-source`
  w                  Alias for `whereami`

Input and Output
  .<shell command>   All text following a '.' is forwarded to the shell.
  cat                Show code from a file, Pry's input buffer, or the last exception.
  fix-indent         Correct the indentation for contents of the input buffer
  save-file          Export to a file using content from the REPL.
  shell-mode         Toggle shell mode. Bring in pwd prompt and file completion.

Misc
  gist               Playback a string variable or a method or a file as input.
  pry-version        Show Pry version.
  reload-code        Reload the source file that contains the specified code object.
  simple-prompt      Toggle the simple prompt.
  toggle-color       Toggle syntax highlighting.

Navigating Pry
  !pry               Start a Pry session on current self.
  disable-pry        Stops all future calls to pry and exits the current session.
  exit               Pop the previous binding.
  exit-all           End the current Pry session.
  exit-program       End the current program.
  jump-to            Jump to a binding further up the stack.
  nesting            Show nesting information.
  switch-to          Start a new subsession on a binding in the current stack.

pry-debugger (v0.2.2)
  break              Set or edit a breakpoint.
  breakpoints        List defined breakpoints.
  continue           Continue program execution and end the Pry session.
  finish             Execute until current stack frame returns.
  next               Execute the next line within the current stack frame.
  step               Step execution into the next line or method.

  fix-indent         Correct the indentation for contents of the input buffer
  save-file          Export to a file using content from the REPL.
  shell-mode         Toggle shell mode. Bring in pwd prompt and file completion.

Misc
  gist               Playback a string variable or a method or a file as input.
  pry-version        Show Pry version.
  reload-code        Reload the source file that contains the specified code object.
  simple-prompt      Toggle the simple prompt.
  toggle-color       Toggle syntax highlighting.

Navigating Pry
  !pry               Start a Pry session on current self.
  disable-pry        Stops all future calls to pry and exits the current session.
  exit               Pop the previous binding.
  exit-all           End the current Pry session.
  exit-program       End the current program.
  jump-to            Jump to a binding further up the stack.
  nesting            Show nesting information.
  switch-to          Start a new subsession on a binding in the current stack.

pry-debugger (v0.2.2)
  break              Set or edit a breakpoint.
  breakpoints        List defined breakpoints.
  continue           Continue program execution and end the Pry session.
  finish             Execute until current stack frame returns.
  next               Execute the next line within the current stack frame.
  step               Step execution into the next line or method.

pry-docmore (v0.1.1)
  show-doc           Show the documentation for a method/class/keyword/global. Aliases: ?
  show-docmores      List keywords and vars covered by pry-docmore

pry-rescue (v1.2.0)
  cd-cause           Move to the exception that caused this exception to happen
  try-again          Re-try the code that caused this exception

pry-stack_explorer (v0.4.9.1)
  down               Go down to the callee's context.
  frame              Switch to a particular frame.
  show-stack         Show all frames
  up                 Go up to the caller's context.

pry-theme (v1.0.0)
  pry-theme          Manage your Pry themes.

Pry custom commands defined in my .pryrc:
  cat(f)           Display text file contents.
  chk	           List current startup info for services.
  dt	           Show the system date and time.
  fl(fn)           Load and execute a Ruby source file.
  gl2(str)         List gems matching search parameter.
  glist	           List all installed gems.
  lc	           Display only filenames in multiple column format.
  lf	           List only filenames, one per line, in alpha order.
  loc	           Display which computer is in use.
  lpci	           List all pci devices.
  lsa	           List all files in filename order.
  lsd	           List only directories.
  lss	           List all files by size from smallest to largest.
  lusb	           List all usb devices.
  path	           Display current PATH.
  pm	           Show methods defined in .pryrc.
  pss	           Display process list.
  pwd	           Print (current) working directory.
  rl 	           Reload and excute the most recently loaded ruby source file.
  rqa(f)           Search for installed RPM.
  sip	           Show location, current ip(s) and network addresses.
  time(&b)         Display execution timing.

=end