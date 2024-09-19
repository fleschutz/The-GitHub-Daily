<#
.SYNOPSIS
        Update the Daily GitHub
.DESCRIPTION
        This PowerShell script writes the Daily GitHub to the standard output.
.EXAMPLE
        PS> ./update > README.md
.LINK
        https://github.com/fleschutz/whats-new
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

function Repo([string]$name, [string]$URLpart) {
	$tags = (Invoke-WebRequest -URI https://api.github.com/repos/$URLpart/tags -userAgent "curl" -useBasicParsing).Content | ConvertFrom-Json
	foreach($tag in $tags) {
		"* [$name](https://api.github.com/repos/$URLpart/tags) $($tag.name)"
		break
	}
}

try {
	"The Daily GitHub - Latest Repo Tags as of SEP 19"
	"================================================"
	Repo "Bazel"            "bazelbuild/bazel"
	Repo "cmake"            "Kitware/CMake"
	Repo "curl"             "curl/curl"
	Repo "Grafana"          "grafana/grafana"
	Repo "LLVM"             "llvm/llvm-project"
	Repo "Ninja"            "ninja-build/ninja"
	Repo "OpenCV"           "opencv/opencv"
	Repo "PowerShell"       "PowerShell/PowerShell"
	Repo "Rust"             "rust-lang/rust"
	Repo "Smartmontools"    "smartmontools/smartmontools"
	Repo "TinyCC"           "TinyCC/tinycc"
	Repo "Windows Terminal" "microsoft/terminal"
	Repo "ZFS"              "openzfs/zfs"

	exit 0 # success
} catch {
}