defmodule WrappingPaper do

	def main(args) do
		# Open the source file
		filename = parse_args args
		case File.open filename, [:read] do
			{:ok, handle}     -> readlines(handle)
				|> parse_lines()
				|> Enum.sum()
				|> IO.puts()
			{:error, :enoent} -> IO.puts "No such file: #{filename}"
		end
		#IO.inspect handle
	end

	def parse_lines(list), do: parse_lines(list, [])

	def parse_lines([], areas), do: areas

	def parse_lines([head | tail], areas) do
		area_of_line = parse_line(head)
			|> calculate_area()
		parse_lines(tail, areas ++ [area_of_line])
	end

	def calculate_area({x, y, z}) do
		a = y * z
		b = x * z
		c = x * y
		# Smallest side needs to be doubled as per the spec
		extra = cond do
			a <= b and a <= c -> a
			b <= c            -> b
			true              -> c
		end

		2 * a + 2 * b + 2 * c + extra
	end

	defp first(tuple), do: elem(tuple, 0)

	def parse_line(string) do
		#IO.inspect string
		String.split(string, "x")
			|> Enum.map(&Integer.parse/1)
			|> Enum.map(&first/1)
			|> List.to_tuple
	end

	def readlines(handle, acc \\ []) do
		case IO.read(handle, :line) do
			{:error, reason} -> IO.puts "Error reading: " <> reason
			:eof             -> acc
			data             -> readlines handle, acc ++ [data]
		end
	end

	# Parse arguments
	defp parse_args([        ]), do: "input.txt"
	defp parse_args([head | _]), do: head

end
