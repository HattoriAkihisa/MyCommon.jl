export yydoysod

using Dates

function yydoysod(s::AbstractString)
    ss = split(s, ':')
    local year
    let yy = parse(Int, ss[1])
        year = (yy > 50) ? 1900 + yy : 2000 + yy
    end

    DateTime(year, 1, 1) + Day(parse(Int, ss[2])) + Second(parse(Int, ss[3]))
end
