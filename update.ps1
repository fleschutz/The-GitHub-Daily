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
	Start-Sleep -seconds 3
	$releases = (Invoke-WebRequest -URI https://api.github.com/repos/$URLpart/releases?per_page=1 -userAgent "curl" -useBasicParsing).Content | ConvertFrom-Json
	foreach($release in $releases) {
		$version = $release.tag_name
		if ($release.published_at -like "2024-09-20T*") { $version += "🆕" }
		"* [$name](https://github.com/$URLpart) $version"
		return
	}
}

try {
	"The Daily GitHub - Latest Releases as of SEP 20"
	"==============================================="
	Repo "curl"               "curl/curl"
	Repo "Grafana"            "grafana/grafana"
	Repo "Hugo"               "gohugoio/hugo"
	Repo "Kubernetes"         "kubernetes/kubernetes"
	Repo "Linux kernel"       "torvalds/linux"
	Repo "Mastodon"           "mastodon/mastodon"
	Repo "OBS Studio"         "obsproject/obs-studio"
	Repo "OpenCV"             "opencv/opencv"
	Repo "PowerToys"          "microsoft/PowerToys"
	Repo "Redis"              "redis/redis"
	Repo "Ruby on Rails"      "rails/rails"
	Repo "Smartmontools"      "smartmontools/smartmontools"
	Repo "Vim"                "vim/vim"
	Repo "Visual Studio Code" "microsoft/vscode"
	Repo "Windows Terminal"   "microsoft/terminal"
	Repo "ZFS"                "openzfs/zfs"
	""
	"Programming Languages"
	"---------------------"
	""
	Repo "CoffeeScript"       "jashkenas/coffeescript"
	Repo "Go"                 "golang/go"
	Repo "Julia"              "JuliaLang/julia"
	Repo "Kotlin"             "JetBrains/kotlin"
	Repo "PHP"                "php/php-src"
	Repo "PowerShell"         "PowerShell/PowerShell"
	Repo "Python"             "python/cpython"
	Repo "Ruby"               "ruby/ruby"
	Repo "Rust"               "rust-lang/rust"
	Repo "Scala"              "scala/scala"
	Repo "Swift"              "swiftlang/swift"
	Repo "TypeScript"         "microsoft/TypeScript"
	""
	"Compiler &amp; Build Systems"
	"----------------------------"
	Repo "Bazel"              "bazelbuild/bazel"
	Repo "CMake"              "Kitware/CMake"
	Repo "Gradle"             "gradle/gradle"
	Repo "Homebrew"           "Homebrew/brew"
	Repo "Jenkins"            "jenkinsci/jenkins"
	Repo "LLVM"               "llvm/llvm-project"
	Repo "Ninja"              "ninja-build/ninja"
	Repo "TinyCC"             "TinyCC/tinycc"
	""
	"(Generated automatically by PowerShell script update.ps1)"
	exit 0 # success
} catch {
        "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
        exit 1
}