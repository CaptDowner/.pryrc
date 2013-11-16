.pryrc
======

My startup file for pry, the awesome REPL tool for Ruby.

Most of these are shortcuts for system command aliases I use,
and I wanted them to be available while running pry.

Most of these are ruby one-liners, but they may help ruby-nubies
get a handle on some of the basic language syntax.

Pry custom commands defined in my .pryrc:
  cat(f)         Display text file contents.
  chk	           List current startup info for services.
  dt	           Show the system date and time.
  fl(fn)         Load and execute a Ruby source file.
  gl2(str)       List gems matching search parameter.
  glist	         List all installed gems.
  lc	           Display only filenames in multiple column format.
  lf	           List only filenames, one per line, in alpha order.
  loc	           Display which computer is in use.
  lpci	         List all pci devices.
  lsa	           List all files in filename order.
  lsd	           List only directories.
  lss	           List all files by size from smallest to largest.
  lusb	         List all usb devices.
  path	         Display current PATH.
  pm	           Show methods defined in .pryrc.
  pss	           Display process list.
  pwd	           Print (current) working directory.
  rl 	           Reload and excute the most recently loaded ruby source file.
  rqa(f)         Search for installed RPM.
  sip	           Show location, current ip(s) and network addresses.
  time(&b)       Display execution timing.

Help using Pry

Pry categories of Help include:

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

After loading pry, you can type 'help' at any time and you will get 
the following output. I include it here as another way to see what 
a great tool pry is for development, and what you can do with it.

Here is the output of the normal 'help' command:

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

