<#
.SYNOPSIS
        Update The Daily GitHub
.DESCRIPTION
        This PowerShell script writes The Daily GitHub to the standard output. It requires GitHub CLI.
.EXAMPLE
        PS> ./bot.ps1 > README.md
.LINK
        https://github.com/fleschutz/whats-new
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

function Repo([string]$name, [string]$URLpart) {
	$releases = (gh api /repos/$URLpart/releases?per_page=1 --method GET) | ConvertFrom-Json
	foreach($release in $releases) {
		$version = $release.tag_name
		if ("$($release.published_at)" -like "2024-09-23T*") { $version += "🆕" }
		return "[$name](https://github.com/$URLpart) $version, "
	}
	return ""
}

try {
	"The Daily GitHub: Latest Repo Releases"
	"======================================"
	""
	"**Welcome to an automatically generated overview of selected GitHub repositories.**"
	""
	$ln = Repo "curl"               "curl/curl"
	$ln += Repo "Hugo"               "gohugoio/hugo"
	$ln += Repo "Linux kernel"       "torvalds/linux"
	$ln += Repo "Mastodon"           "mastodon/mastodon"
	$ln += Repo "OBS Studio"         "obsproject/obs-studio"
	$ln += Repo "OpenCV"             "opencv/opencv"
	$ln += Repo "OpenMCT"            "nasa/openmct"
	$ln += Repo "PowerToys"          "microsoft/PowerToys"
	$ln += Repo "Redis"              "redis/redis"
	$ln += Repo "Smartmontools"      "smartmontools/smartmontools"
	$ln += Repo "Vim"                "vim/vim"
	$ln += Repo "Windows Terminal"   "microsoft/terminal"
	$ln += Repo "ZFS"                "openzfs/zfs"
	"**Today Sept. 23,** the latest releases in the **Featured** section are: $ln"
	""
	$ln = Repo "AssemblyScript"     "AssemblyScript/assemblyscript"
	$ln += Repo "C#"                 "dotnet/csharplang"
	$ln += Repo "Clojure"            "clojure/clojure"
	$ln += Repo "CoffeeScript"       "jashkenas/coffeescript"
	$ln += Repo "Crystal"            "crystal-lang/crystal"
	$ln += Repo "Go"                 "golang/go"
	$ln += Repo "Elixir"             "elixir-lang/elixir"
	$ln += Repo "Elm"                "elm/compiler"
	$ln += Repo "Erlang"             "erlang/otp"
	$ln += Repo "Groovy"             "apache/groovy"
	$ln += Repo "Julia"              "JuliaLang/julia"
	$ln += Repo "Kotlin"             "JetBrains/kotlin"
	$ln += Repo "MicroPython"        "micropython/micropython"
	$ln += Repo "Mojo"               "modularml/mojo"
	$ln += Repo "Nim"                "nim-lang/Nim"
	$ln += Repo "Odin"               "odin-lang/Odin"
	$ln += Repo "Orca"               "hundredrabbits/Orca"
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
	"In **Programming Languages** we have: $ln"
	""
	$ln = Repo "Apache Ant"         "apache/ant"
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
	"Looking at **Compiler &amp; Build Systems** we have: $ln"
	""
	$ln = Repo "Atom"               "atom/atom"
	$ln += Repo "GNU Emacs"          "emacs-mirror/emacs"
	$ln += Repo "NetBeans"           "apache/netbeans"
	$ln += Repo "NeoVim"             "neovim/neovim"
	$ln += Repo "TextMate"           "textmate/textmate"
	$ln += Repo "Nano"               "madnight/nano"
	$ln += Repo "Notepad++"          "notepad-plus-plus/notepad-plus-plus"
	$ln += Repo "Vim"                "vim/vim"
	$ln += Repo "Visual Studio Code" "microsoft/vscode"
	$ln += Repo "Zed"                "zed-industries/zed"
	"In **Text Editors** we are at: $ln"
	""
	$ln = Repo "Ansible"            "ansible/ansible"
	$ln += Repo "Capistrano"         "capistrano/capistrano"
	$ln += Repo "Chef"               "chef/chef"
	$ln += Repo "Grafana"            "grafana/grafana"
	$ln += Repo "Jenkins"            "jenkinsci/jenkins"
	$ln += Repo "Kubernetes"         "kubernetes/kubernetes"
	$ln += Repo "Moby"               "moby/moby"
	$ln += Repo "OpenStack"          "openstack/openstack"
	$ln += Repo "Prometheus"         "prometheus/prometheus"
	$ln += Repo "Puppet"             "puppetlabs/puppet"
	$ln += Repo "Salt"               "saltstack/salt"
	$ln += Repo "statsd"             "statsd/statsd"
	$ln += Repo "Terraform"          "hashicorp/terraform"
	$ln += Repo "Vagrant"            "hashicorp/vagrant"
	"And last but not least **DevOps** with: $ln"
	""
	"That's it for today but stay tuned. See you next time."
	exit 0 # success
} catch {
        "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
        exit 1
}