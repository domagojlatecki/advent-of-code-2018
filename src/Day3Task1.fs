open System
open System.Text.RegularExpressions

let inputStream =
    Seq.initInfinite(fun _ -> Console.ReadLine()) |> Seq.takeWhile (fun line -> line <> null)

let (|Integer|_|) (str: string) =
    let mutable intvalue = 0
    if System.Int32.TryParse(str, &intvalue) then Some(intvalue)
    else None

let (|ParseRegex|_|) regex str =
    let m = Regex(regex).Match(str)
    if m.Success
    then Some (List.tail [for x in m.Groups -> x.Value])
    else None

let parseLine line =
    match line with
        | ParseRegex "#(\d+) @ (\d+),(\d+): (\d+)x(\d+)" [Integer id; Integer x; Integer y; Integer width; Integer height]
            -> (id, x, y, width, height)
        | _ -> failwith ("unparsable input: " + line)

let unwrapValues tuple =
    let id, x, y, width, height = tuple
    let coords = [for i in x..(x + width - 1) -> [for j in y..(y + height - 1) -> (i, j)]]
    List.collect(fun x -> x) coords

[<EntryPoint>]
let main argv =
    let counts = inputStream |> Seq.map parseLine |> Seq.map unwrapValues |> Seq.collect(fun x -> x) |> Seq.countBy id
    let numOverlapping = counts |> Seq.map(fun (k, v) -> v) |> Seq.filter(fun v -> v <> 1) |> Seq.length
    printfn "%d" numOverlapping
    0
