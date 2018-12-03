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
        | _ -> failwith("unparsable input: " + line)

let unwrapValues tuple =
    let id, x, y, width, height = tuple
    let coords = [for i in x..(x + width - 1) -> [for j in y..(y + height - 1) -> (i, j, id)]]
    List.collect(fun x -> x) coords

[<EntryPoint>]
let main argv =
    let claims = inputStream |> Seq.map parseLine |> Seq.map unwrapValues |> Seq.toList
    let overlaps = claims |> Seq.collect(fun x -> x) |> Seq.map(fun (x, y, i) -> x, y) |> Seq.countBy id |> dict
    let nonOverlapping = claims |> Seq.filter(fun claim -> claim |> Seq.forall(fun (x, y, i) -> overlaps.Item(x, y) = 1))
    let ids = nonOverlapping |> Seq.collect(fun x -> x) |> Seq.map(fun (x, y, i) -> i) |> Set.ofSeq |> Set.toList
    let id = match ids with
                | [i] -> i
                | _ -> failwith("single id was expected")
    printfn "%d" id
    0
