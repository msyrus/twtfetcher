package cmd

import (
	"runtime"

	"github.com/msyrus/twtfetcher/version"
	"github.com/spf13/cobra"
)

var versionCmd = &cobra.Command{
	Use:   "version",
	Short: "Print app version",
	Long:  `Print the version of app`,
	Run:   printV,
}

func init() {
	RootCmd.AddCommand(versionCmd)
}

func printV(cmd *cobra.Command, args []string) {
	println("App Version:", version.Version)
	println("Go Version:", runtime.Version())
	println("Go OS/ARCH:", runtime.GOOS, runtime.GOARCH)
}
