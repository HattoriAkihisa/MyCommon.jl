export readdir,
       readdirrec


function readdir(path::AbstractString; hidden = true)
    hidden ? Base.Filesystem.readdir(path) : filter(f -> f[1] != '.',Base.Filesystem.readdir(path))
end


"""
# readdir を再帰的に実行
    `readdirrec(path; max, hidden)`
    `path::AbstractString`: 検索するディレクトリ
    `max::Int`: 検索する最大深度
    `hidden::Bool`: 隠しファイルを読み込むかどうか
"""
function readdirrec(path::AbstractString; max = -1, hidden = false)
    fd = joinpath.(path,readdir(path,hidden=hidden))

    max == 1 && return fd

    f  = filter(isfile,fd)
    d  = filter(isdir,fd)

    if !isempty(d)
        append!(f,vcat(map(ff -> readdirrec(ff,max = max - 1,hidden=hidden),d)...))
    end

    return f
end
