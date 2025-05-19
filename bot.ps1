<#
.SYNOPSIS
        The bot writing 'The GitHub Daily'
.DESCRIPTION
        This PowerShell script writes the text content for 'The GitHub Daily' into README.md.
	Required is PowerShell, Git and GitHub CLI.
.EXAMPLE
        PS> ./bot.ps1
.LINK
        https://github.com/fleschutz/the-github-daily
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

param([string]$month = "May", [string]$searchPattern = "2025-05-*")

function WriteLine([string]$line) {
	Write-Output $line >> README.md
}

function Repo([string]$name, [string]$URLpart, [string]$versionPrefix) {
	Write-Host "." -noNewline
	$global:numRepos++
	$releases = (gh api /repos/$URLpart/releases?per_page=1 --method GET) | ConvertFrom-Json
	if ($releases.Count -ge 1) {
		$latestReleases = (gh api /repos/$URLpart/releases/latest?per_page=9 --method GET) | ConvertFrom-Json
		foreach($release in $latestReleases) {
			if ($release.prerelease -eq "true") { continue }
			$version = $release.tag_name
			if ($version -like $versionPrefix) { $version = $version.Substring($versionPrefix.Length - 1) }
			if ("$($release.published_at)" -like $searchPattern) { $version += "🔅" }
			return "[$name](https://github.com/$URLpart) $version, "
		}
	}
	$tags = (gh api /repos/$URLpart/tags?per_page=9 --method GET) | ConvertFrom-Json
	if ($tags.Count -ge 1) {
		foreach($tag in $tags) {
			$version = $tag.name
			if ($version -like $versionPrefix) { $version = $version.Substring($versionPrefix.Length - 1) }
			$commitID = $tag.commit.sha
			$commit = (gh api /repos/$URLpart/commits/$commitID --method GET) | ConvertFrom-Json
			$commitDate = $commit.commit.committer.date
			if ($commitDate -notlike "2025-*") { continue }
			if ($commitDate -like $searchPattern) { $version += "🔖" }
			return "[$name](https://github.com/$URLpart) $version, "
		}
		return "[$name](https://github.com/$URLpart) $($version)💤, "
	}
	return "[$name](https://github.com/$URLpart), "
}

try {
        Write-Host "⏳ (1/7) Searching for PowerShell...            $($PSVersionTable.PSVersion) $($PSVersionTable.PSEdition) edition"
        Write-Host "⏳ (2/7) Searching for Git...                   " -noNewline
	& git --version
        if ($lastExitCode -ne 0) { throw "Can't execute 'git' - make sure Git is installed and available" }

        Write-Host "⏳ (3/7) Searching for GitHub CLI...            " -noNewline
        & gh --version
        if ($lastExitCode -ne 0) { throw "Can't execute 'gh --version' - make sure GitHub CLI is installed and available" }

	Write-Host "⏳ (4/7) Pulling latest repo updates...         " -noNewline
        & git pull
        if ($lastExitCode -ne 0) { throw "Can't execute 'git pull' - make sure Git is installed and available" }

	Write-Host "⏳ (5/7) Querying GitHub repos and writing README.md..." -noNewline
        [system.threading.thread]::currentthread.currentculture = [system.globalization.cultureinfo]"en-US"
        $today = (Get-Date).ToShortDateString()
	$global:numRepos = 0
	Write-Output "" > README.md
	WriteLine "📰 The GitHub Daily"
	WriteLine "==================="
	WriteLine ""

	$ln = Repo "curl"                "curl/curl"                   "curl-*"
	$ln += Repo "Git"                "git/git"                     "v*"
	$ln += Repo "Hugo"               "gohugoio/hugo"               "v*"
	$ln += Repo "Kodi"               "xbmc/xbmc"		       "v*"
	$ln += Repo "Linux"              "torvalds/linux"              "v*"
	$ln += Repo "Mastodon"           "mastodon/mastodon"           "v*"
	$ln += Repo "OpenMCT"            "nasa/openmct"                "v*"
	$ln += Repo "Redis"              "redis/redis"                 ""
	$ln += Repo "Smartmontools"      "smartmontools/smartmontools" "RELEASE_*"
	$ln += Repo "ZFS"                "openzfs/zfs"                 "zfs-*"
	WriteLine "Today the latest releases of **featured** GitHub repositories in **$month** are: $ln`n"

	$ln = Repo "Audacity"            "audacity/audacity"           "Audacity-*"
	$ln += Repo "Blender"            "blender/blender"             "v*"
	$ln += Repo "Brave"              "brave/brave-browser"         "v*"
	$ln += Repo "Chromium"           "chromium/chromium"           ""
	$ln += Repo "Dopamine"           "digimezzo/dopamine-windows"  "v*"
	$ln += Repo "CodeEdit"           "CodeEditApp/CodeEdit"        "v*"
	$ln += Repo "FFmpeg"             "FFmpeg/FFmpeg"               "v*"
	$ln += Repo "Firefox"            "mozilla-firefox/firefox"     ""
	$ln += Repo "FreeRDP"            "FreeRDP/FreeRDP"             ""
	$ln += Repo "GIMP"               "GNOME/gimp"                  ""
	$ln += Repo "Git Extensions"     "gitextensions/gitextensions" "v*"
	$ln += Repo "LibreOffice"        "LibreOffice/core"            ""
	$ln += Repo "Meld"               "GNOME/meld"                  "split-*"
	$ln += Repo "Nextcloud Desktop"  "nextcloud/desktop"           "v*"
	$ln += Repo "OBS Studio"         "obsproject/obs-studio"       ""
	$ln += Repo "OctoPrint"          "OctoPrint/OctoPrint"         ""
	$ln += Repo "PowerToys"          "microsoft/PowerToys"         "v*"
	$ln += Repo "PrusaSlicer"        "prusa3d/PrusaSlicer"         "version_*"
	$ln += Repo "Serenade"           "serenadeai/serenade"         ""
	$ln += Repo "VLC"                "videolan/vlc"                ""
	$ln += Repo "Windows Terminal"   "microsoft/terminal"          "v*"
	$ln += Repo "Zen Browser"        "zen-browser/desktop"         ""
	WriteLine "In **General Apps** it's $ln`n"

	$ln = Repo "Atom"                "atom/atom"                   "v*"
	$ln += Repo "Brackets"           "brackets-cont/brackets"      "v*"
	$ln += Repo "ghostwriter"        "KDE/ghostwriter"             ""
	$ln += Repo "GNU Emacs"          "emacs-mirror/emacs"          ""
	$ln += Repo "Helix"              "helix-editor/helix"          ""
	$ln += Repo "Nano"               "madnight/nano"               ""
	$ln += Repo "NetBeans"           "apache/netbeans"             ""
	$ln += Repo "Neovim"             "neovim/neovim"               "v*"
	$ln += Repo "Notepad++"          "notepad-plus-plus/notepad-plus-plus" "v*"
	$ln += Repo "TextMate"           "textmate/textmate"           "v*"
	$ln += Repo "Typedown"           "byxiaozhi/Typedown"          ""
	$ln += Repo "Vim"                "vim/vim"                     "v*"
	$ln += Repo "Visual Studio Code" "microsoft/vscode"            ""
	$ln += Repo "Zed"                "zed-industries/zed"          "v*"
	WriteLine "In **Text Editors** and **IDEs** the latest are $ln`n"

	$ln = Repo "AssemblyScript"      "AssemblyScript/assemblyscript" "v*"
	$ln += Repo "C#"                 "dotnet/csharplang"             ""
	$ln += Repo "Clojure"            "clojure/clojure"               "clojure-*"
	$ln += Repo "CoffeeScript"       "jashkenas/coffeescript"        ""
	$ln += Repo "Crystal"            "crystal-lang/crystal"          ""
	$ln += Repo "Go"                 "golang/go"                     "go*"
	$ln += Repo "Elixir"             "elixir-lang/elixir"            "v*"
	$ln += Repo "Elm"                "elm/compiler"                  ""
	$ln += Repo "Erlang"             "erlang/otp"                    "OTP-*"
	$ln += Repo "Groovy"             "apache/groovy"                 "GROOVY_*"
	$ln += Repo "Julia"              "JuliaLang/julia"               "v*"
	$ln += Repo "Kotlin"             "JetBrains/kotlin"              "v*"
	$ln += Repo "MicroPython"        "micropython/micropython"       "v*"
	$ln += Repo "Mojo"               "modularml/mojo"                "modular/v*"
	$ln += Repo "Nim"                "nim-lang/Nim"                  "v*"
	$ln += Repo "Odin"               "odin-lang/Odin"                ""
	$ln += Repo "Orca"               "hundredrabbits/Orca"           ""
	$ln += Repo "PHP"                "php/php-src"                   "yaf-*"
	$ln += Repo "PowerShell"         "PowerShell/PowerShell"         "v*"
	$ln += Repo "Python"             "python/cpython"                "v*"
	$ln += Repo "Roslyn"             "dotnet/roslyn"                 "v*"
	$ln += Repo "Ruby"               "ruby/ruby"                     "v*"
	$ln += Repo "Ruby on Rails"      "rails/rails"                   "v*"
	$ln += Repo "Rust"               "rust-lang/rust"                ""
	$ln += Repo "Scala"              "scala/scala"                   "v*"
	$ln += Repo "Swift"              "swiftlang/swift"               "swift-*"
	$ln += Repo "TypeScript"         "microsoft/TypeScript"          "v*"
	$ln += Repo "Zig"                "ziglang/zig"                   ""
	WriteLine "In **Programming Languages** it's $ln`n"

	$ln = Repo "alsa-lib"            "alsa-project/alsa-lib"   "v*"
	$ln += Repo "BitNet"             "microsoft/BitNet"        ""
	$ln += Repo "Boost"              "boostorg/boost"          "boost-*"
	$ln += Repo "DeepSeek-R1"        "deepseek-ai/DeepSeek-R1" ""
	$ln += Repo "DeepSeek Janus"	 "deepseek-ai/Janus"	   ""
	$ln += Repo "libarchive"         "libarchive/libarchive"   "v*"
	$ln += Repo "libexpat"           "libexpat/libexpat"       "R_*"
	$ln += Repo "libgit2"            "libgit2/libgit2"         "v*"
	$ln += Repo "libyuv"             "lemenkov/libyuv"         ""
	$ln += Repo "OpenCV"             "opencv/opencv"           ""
	$ln += Repo "OpenEXR"            "AcademySoftwareFoundation/openexr" "v*"
	$ln += Repo "OpenVDB"            "AcademySoftwareFoundation/openvdb" "v*"
	$ln += Repo "NVIDIA PhysX"       "NVIDIA-Omniverse/PhysX"  ""
	$ln += Repo "Plog"               "SergiusTheBest/plog"     ""
	$ln += Repo "SymCrypt"           "microsoft/SymCrypt"      "v*"
	$ln += Repo "TensorFlow"         "tensorflow/tensorflow"   "v*"
	$ln += Repo "Whisper"            "openai/whisper"          "v*"
	WriteLine "In **Software Libs/SDKs/AI** the latest and greatest are $ln`n"

	$ln = Repo "Ant"                 "apache/ant"          ""
	$ln += Repo "Bazel"              "bazelbuild/bazel"    ""
	$ln += Repo "CMake"              "Kitware/CMake"       "v*"
	$ln += Repo "Gradle"             "gradle/gradle"       "v*"
	$ln += Repo "Homebrew"           "Homebrew/brew"       ""
	$ln += Repo "LLVM"               "llvm/llvm-project"   "llvmorg-*"
	$ln += Repo "Maven"              "apache/maven"        "maven-*"
	$ln += Repo "Meson"              "mesonbuild/meson"    ""
	$ln += Repo "Ninja"              "ninja-build/ninja"   "v*"
	$ln += Repo "Pants"              "pantsbuild/pants"    "release_*"
	$ln += Repo "TinyCC"             "TinyCC/tinycc"       "release_*"
	WriteLine "Looking at **Compiler** and **Build Systems** there's $ln`n"

	$ln = Repo "Ansible"             "ansible/ansible"       "v*"
	$ln += Repo "Capistrano"         "capistrano/capistrano" "v*"
	$ln += Repo "Chef"               "chef/chef"             "v*"
	$ln += Repo "Grafana"            "grafana/grafana"       "v*"
	$ln += Repo "Jenkins"            "jenkinsci/jenkins"     "jenkins-*"
	$ln += Repo "Kubernetes"         "kubernetes/kubernetes" "v*"
	$ln += Repo "Moby"               "moby/moby"             "v*"
	$ln += Repo "OpenStack"          "openstack/openstack"   ""
	$ln += Repo "Prometheus"         "prometheus/prometheus" "v*"
	$ln += Repo "Puppet"             "puppetlabs/puppet"     ""
	$ln += Repo "Salt"               "saltstack/salt"        "v*"
	$ln += Repo "statsd"             "statsd/statsd"         "v*"
	$ln += Repo "Terraform"          "hashicorp/terraform"   "v*"
	$ln += Repo "Vagrant"            "hashicorp/vagrant"     "v*"
	WriteLine "And last but not least **DevOps** with $ln`n"

	WriteLine "**Legend:** 🆕 *= new project in $month,* 🔅 *= new release in $month,* 🔖 *= new tag in $month*, 💤 *= no activity in 2025*.`n"
	WriteLine "**Statistics:** $($global:numRepos) repos scanned, last update: $($today) by 🤖[bot.ps1](bot.ps1)`n"

	Write-Host "`n⏳ (6/7) Committing updated README.md..."
	& git add README.md
	if ($lastExitCode -ne 0) { throw "Executing 'git add README.md' failed with exit code $lastExitCode" }

	& git commit -m "Updated README.md"
	if ($lastExitCode -ne 0) { throw "Executing 'git commit' failed with exit code $lastExitCode" }

	Write-Host "⏳ (7/7) Pushing updated README.md..."
	& git push
	if ($lastExitCode -ne 0) { throw "Executing 'git push' failed with exit code $lastExitCode" }

	Write-Host "✅ Update succeeded, see: " -noNewline
	Write-Host "https://github.com/fleschutz/the-github-daily" -foregroundColor blue -noNewline
	Write-Host " (use <Ctrl> + <click>)"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
