
{log,error} = require "daizoru-toolbox"

main = (model, a=[]) ->
  stack = model
  msg = ""
  for i in [0...a.length]
    if stack[a[i]]?
      msg += "." unless msg.length is 0
      msg += "#{a[i]}"
      stack = stack[a[i]]
      if i is a.length - 1
        #log "end of stack, calling.."
        stack()
      
    else
      try
        #log "calling stack.func #{a[i..]}..."
        stack a[i..]...
      catch e
        #log "exception: #{e}"
        if msg.length is 0
          if a.length is 0
            model.help.default()
          else
            error "never heard about '#{a[0]}'"
        else
          error "never heard about #{msg}"
        return

module.exports = (model) ->
  main model, process.argv[2..]