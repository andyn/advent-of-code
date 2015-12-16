defmodule WrappingPaper do

	def main(args) do
		# Open the source file
		filename = parse_args(args)
		case File.open filename, [:read] do
			{:ok, handle}     -> readlines(handle)
				|> parse_lines()
				# Sum of tuples
				|> Enum.reduce(fn({a, b}, {c, d}) -> {a + c, b + d} end)
				|> show
			{:error, :enoent} -> IO.puts "No such file: #{filename}"
		end
		#IO.inspect handle
	end

	def show({paper, ribbon}) do
		IO.puts("Need #{paper} ft^2 of paper")
		IO.puts("Need #{ribbon} ft of ribbon")
	end

	def parse_lines(list), do: parse_lines(list, [])

	defp parse_lines([], areas), do: areas

	defp parse_lines([head | tail], areas) do
		dimensions = parse_line(head)
		paper = calculate_paper(dimensions)
		ribbon = calculate_ribbon(dimensions)
		parse_lines(tail, areas ++ [{paper, ribbon}])
	end

	def calculate_paper({x, y, z}) do
		a = y * z
		b = x * z
		c = x * y
		# Smallest side needs to be doubled as per the spec
		extra = cond do
			a <= b and a <= c -> a
			b <= c            -> b
			true              -> c
		end

		a + a + b + b + c + c + extra
	end

	def calculate_ribbon({x, y, z}) do
		shortest_distance = cond do
			x <= z and y <= z -> x + x + y + y
			x <= y and z <= y -> x + x + z + z
			true              -> y + y + z + z
		end

		shortest_distance + x * y * z
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
