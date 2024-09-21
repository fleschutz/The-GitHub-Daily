<#
.SYNOPSIS
        Update The Daily GitHub
.DESCRIPTION
        This PowerShell script writes The Daily GitHub to the standard output.
.EXAMPLE
        PS> ./AI.ps1 > README.md
.LINK
        https://github.com/fleschutz/whats-new
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

function Repo([string]$name, [string]$URLpart) {
	Start-Sleep -seconds 5
	$releases = (Invoke-WebRequest -URI https://api.github.com/repos/$URLpart/releases?per_page=1 -userAgent "curl" -useBasicParsing).Content | ConvertFrom-Json
	foreach($release in $releases) {
		$version = $release.tag_name
		if ($release.published_at -like "2024-09-21T*") { $version += "🆕" }
		return "[$name](https://github.com/$URLpart) $version, "
	}
	return ""
}

try {
	"The Daily GitHub: Latest Releases"
	"================================="
	""
	"Welcome to an automatically generated overview of selected GitHub repositories as of September 21, 2024."
	""
	$ln = ""
	$ln += Repo "curl"               "curl/curl"
	$ln += Repo "Hugo"               "gohugoio/hugo"
	$ln += Repo "Linux kernel"       "torvalds/linux"
	$ln += Repo "Mastodon"           "mastodon/mastodon"
	$ln += Repo "OBS Studio"         "obsproject/obs-studio"
	$ln += Repo "OpenCV"             "opencv/opencv"
	$ln += Repo "PowerToys"          "microsoft/PowerToys"
	$ln += Repo "Redis"              "redis/redis"
	$ln += Repo "Smartmontools"      "smartmontools/smartmontools"
	$ln += Repo "Vim"                "vim/vim"
	$ln += Repo "Visual Studio Code" "microsoft/vscode"
	$ln += Repo "Windows Terminal"   "microsoft/terminal"
	$ln += Repo "ZFS"                "openzfs/zfs"
	"The latest releases in the **Featured** section are $ln"
	""
	""
	$ln = ""
	$ln += Repo "AssemblyScript"     "AssemblyScript/assemblyscript"
	$ln += Repo "Clojure"            "clojure/clojure"
	$ln += Repo "CoffeeScript"       "jashkenas/coffeescript"
	$ln += Repo "Crystal"            "crystal-lang/crystal"
	$ln += Repo "Go"                 "golang/go"
	$ln += Repo "Elixir"             "elixir-lang/elixir"
	$ln += Repo "Erlang"             "erlang/otp"
	$ln += Repo "Julia"              "JuliaLang/julia"
	$ln += Repo "Kotlin"             "JetBrains/kotlin"
	$ln += Repo "MicroPython"        "micropython/micropython"
	$ln += Repo "Nim"                "nim-lang/Nim"
	$ln += Repo "PHP"                "php/php-src"
	$ln += Repo "PowerShell"         "PowerShell/PowerShell"
	$ln += Repo "Python"             "python/cpython"
	$ln += Repo "Roslyn"             "dotnet/roslyn"
	$ln += Repo "Ruby"               "ruby/ruby"
	$ln += Repo "Ruby on Rails"      "rails/rails"
	$ln += Repo "Rust"               "rust-lang/rust"
	$ln += Repo "Scala"              "scala/scala"
	$ln += Repo "Swift"              "swiftlang/swift"
	$ln += Repo "TypeScript"         "microsoft/TypeScript"
	"In **Programming Languages** we have $ln"
	""
	""
	$ln = ""
	$ln += Repo "Apache Ant"         "apache/ant"
	$ln += Repo "Bazel"              "bazelbuild/bazel"
	$ln += Repo "CMake"              "Kitware/CMake"
	$ln += Repo "Gradle"             "gradle/gradle"
	$ln += Repo "Homebrew"           "Homebrew/brew"
	$ln += Repo "LLVM"               "llvm/llvm-project"
	$ln += Repo "Maven"              "apache/maven"
	$ln += Repo "Meson"              "mesonbuild/meson"
	$ln += Repo "Ninja"              "ninja-build/ninja"
	$ln += Repo "Pants"              "pantsbuild/pants"
	$ln += Repo "TinyCC"             "TinyCC/tinycc"
	"Looking at **Compiler &amp; Build Systems** we have $ln"
	""
	""
	$ln = ""
	$ln += Repo "Ansible"            "ansible/ansible"
	$ln += Repo "Chef"               "chef/chef"
	$ln += Repo "Grafana"            "grafana/grafana"
	$ln += Repo "Jenkins"            "jenkinsci/jenkins"
	$ln += Repo "Kubernetes"         "kubernetes/kubernetes"
	$ln += Repo "Puppet"             "puppetlabs/puppet"
	$ln += Repo "Salt"               "saltstack/salt"
	$ln += Repo "Terraform"          "hashicorp/terraform"
	"And last but not least **DevOps** with $ln"
	""
	""
	"That's it for now but stay tuned. See you next time."
	exit 0 # success
} catch {
        "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
        exit 1
}