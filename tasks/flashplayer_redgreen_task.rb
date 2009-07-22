module Sprout
  class FlashPlayerTask < Rake::Task
			COLORS = { 'F' => 31,	'E' => 35, 'M' => 33, :ok => 32	}

			# thank you rspec for win32 support ;)
			# http://rspec.info/
			COLORIZE = true
			if RUBY_PLATFORM =~ /mswin|mingw/ ;\
			  begin ;\
			    require 'rubygems' unless ENV['NO_RUBYGEMS'] ;\
			    require 'Win32/Console/ANSI' ;\
				 	COLORIZE = true
			  rescue LoadError ;\
			    warn "You must 'gem install win32console' to use colour on Windows" ;\
					COLORIZE = false
			  end
			end

			def colorize_string(text, color); "\e[1m\e[#{COLORS[color]}m#{text}\e[0m"; end

			def colorize_result(text)
				out = text.sub('[trace] [as3spec]', '[as3spec]')
				# return out if PLATFORM =~ /win32/ 
				return out unless COLORIZE

				requirement_color = case out
				when /(FAILED|ERROR|MISSING)/ then $1[0..0] # SpecDox, Tap, Knock
				when /\A([FME])\Z/ then $1 # TestUnit
				else :ok
				end

				summary_color = out.match(/0 failures, 0 errors/).nil? ? 'F' : :ok

				out.sub(/^\[as3spec\] (- .*)?$/, 
					colorize_string('\1', requirement_color)).sub(/\[as3spec\]\s*/, '').sub(/^.+\d+ failures, \d+ errors$/, 
						colorize_string('\0', summary_color))
			end

			def puts(*args)
				args.map! { |arg| arg.instance_of?(String) ? colorize_result(arg) : arg }
				super(args)
			end

			def print(*args)
				args.map! { |arg| arg.instance_of?(String) ? colorize_result(arg) : arg }
				super(args)
			end
	end
end