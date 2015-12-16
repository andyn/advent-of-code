# Advent of code day 1a
# Antti Nilakari <antti.nilakari@iki.fi>

defmodule CountParens do
	
	def main _ do
		string = IO.read :all
		count string
	end

	def count string do
		count string, 0, 0
	end

	defp count _, -1, pos do
		IO.puts(pos)
	end

	defp count string, acc, pos do
		case string do
			"("   <> rest -> count rest, acc + 1, pos + 1
			")"   <> rest -> count rest, acc - 1, pos + 1
			<<_>> <> rest -> count rest, acc,     pos + 1
			""            -> nil
		end
	end

end
