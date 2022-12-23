load("@build_stack_rules_hugo//hugo:rules.bzl", "hugo_site", "hugo_theme", "hugo_serve")

load("@io_bazel_rules_docker//container:container.bzl", "container_image", "container_layer", "container_push")

load("@io_bazel_rules_k8s//k8s:object.bzl", "k8s_object")

hugo_theme(
    name = "hugo-paper",
    srcs = [
        "@com_github_nanxiaobei_hugo_paper//:files",
    ],
)

hugo_theme(
    name = "augustfeng.app",
    srcs = [
        "themes/augustfeng.app",
    ],
)

hugo_site(
    name = "html",
    config = "config.toml",
    content = glob(["content/articles/**"]),
    quiet = False,
    themes = [":hugo-paper", ":augustfeng.app"],
)

hugo_serve(
    name = "serve",
    dep = [":html"],
)

container_layer(
    name = "html-layer",
    files = [":html"],
    directory = "/usr/share/nginx/",
)

container_image(
    name = "image",
    base = "@nginx//image",
    labels = {
        "org.opencontainers.image.source": "https://github.com/augustfengd/augustfeng.app",
    },
    ports = [
        "80/tcp",
    ],
    layers = [":html-layer"],
)

genrule(
    name = "secrets",
    cmd = "sops --output $(location :config.json) -d $(location :config.enc.json)", # requires SOPS_AGE_KEY: `bazel build secrets --action_env=SOPS_AGE_KEY=$SOPS_AGE_KEY`
    srcs = ["config.enc.json"],
    outs = ["config.json"]
)

container_push(
    name = "publish",
    image = ":image",
    format = "Docker",
    registry = "ghcr.io",
    repository = "augustfengd/augustfeng.app/blog",
    tag = "latest",
)

k8s_object(
    name = "deployment",
    kubeconfig = ":kubeconfig.yaml",
    context = "augustfeng-app",
    namespace = "apps-blog",
    template = ":deployment.yaml",
    images = {
        "ghcr.io/augustfengd/augustfeng.app/blog": ":image"
    },
)
