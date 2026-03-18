vim.lsp.config(
    "gopls",
    {
        settings = {
            gopls = {
                directoryFilters = {
                    "-bazel-bin",
                    "-bazel-out",
                    "-bazel-testlogs",
                    "-bazel-yak",
                },
            },
        },
        cmd_env = {
            GOPACKAGESDRIVER = vim.fn.expand("~/dev/yak/saq/common/build/go/gopackagesdriver.sh"),
        },
    }
)
vim.lsp.enable("gopls")
