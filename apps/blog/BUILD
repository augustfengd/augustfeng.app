load("@build_stack_rules_hugo//hugo:rules.bzl", "hugo_site", "hugo_theme", "hugo_serve")

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
    name = "blog",
    config = "config.toml",
    content = glob(["content/articles/**"]),
    quiet = False,
    themes = [":hugo-paper", ":augustfeng.app"],
)

hugo_serve(
    name = "serve",
    dep = [":blog"],
)
