type Context =
    { DISCORD_TOKEN : string }

module Context =
    let build () =
        { DISCORD_TOKEN = System.Environment.GetEnvironmentVariable "DISCORD_TOKEN" } // TODO: validate this.

let run (ctx : Context) =
    0

[<EntryPoint>]
let main _ =
    let ctx = Context.build ()
    0
