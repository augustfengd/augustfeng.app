open System
open System.Text
open System.Text.Json
open System.Threading.Tasks
open Microsoft.Extensions.Configuration
open System.Security.Cryptography
open Octokit

type Flags =
    { ClientId : int32
      PrivateKey : string }

type JwtHeader =
    { alg: string
      typ: string }

type JwtClaims =
      { iat: int64
        exp: int64
        iss: string }

let getFlags () =
    let configuration = ConfigurationBuilder()
                            .AddJsonFile("appsettings.json")
                            .AddEnvironmentVariables()
                            .Build()
    
    configuration.Get<Flags>()

let encodeBase64Url = Convert.ToBase64String >> _.Replace('+', '-').Replace('/','_') >> _.TrimEnd('=')

let makeJwtHeader () =
    { alg = "RS256"
      typ = "JWT" }

let makeJwtPayload clientId =
    { iat = System.DateTimeOffset.UtcNow.AddSeconds(-10).ToUnixTimeSeconds()
      exp = System.DateTimeOffset.UtcNow.AddMinutes(10).ToUnixTimeSeconds()
      iss = string clientId }
    
let buildSigner (pem : string) (data : byte array) =
    let rsa = RSA.Create()
    rsa.ImportFromPem(pem.AsSpan())
    rsa.SignData(data, HashAlgorithmName.SHA256, RSASignaturePadding.Pkcs1)

let makeJwt header payload pem = 
    let sign = buildSigner pem
    let data = $"{header}.{payload}" |> Encoding.UTF8.GetBytes
    let signature = sign data |> encodeBase64Url
    $"%s{header}.%s{payload}.%s{signature}"
    
let makeApp jwt =
    let credentials = Credentials(jwt, AuthenticationType.Bearer)
    let app = new GitHubClient(new ProductHeaderValue("augustfeng.app"))
    app.Credentials <- credentials
    app
    
let makeInstallation id token =
    let credentials = Credentials(token)
    let installation = new GitHubClient(new ProductHeaderValue("augustfeng.app"))
    installation.Credentials <- credentials
    installation
 
let approvePr (client : GitHubClient) n =
    let review = PullRequestReviewCreate()
    review.Event <- PullRequestReviewEvent.Approve
    client.PullRequest.Review.Create("augustfengd", "learn.things", 1, review).Wait()

let run flags =
    let header = makeJwtHeader () |> JsonSerializer.SerializeToUtf8Bytes |> encodeBase64Url
    let payload = makeJwtPayload flags.ClientId |> JsonSerializer.SerializeToUtf8Bytes |> encodeBase64Url
    let jwt = makeJwt header payload flags.PrivateKey
    let app = makeApp jwt |> _.GitHubApps
    let installationId = app.GetAllInstallationsForCurrent().Result |> Seq.head |> _.Id 
    let token = app.CreateInstallationToken(installationId).Result |> _.Token
    let installation = makeInstallation installationId token
    approvePr installation 1
    0

[<EntryPoint>]
let main _ =
    let flags = getFlags()
    run flags
    0