%define _prefix /gem_base/epics/ioc
%define name gws_mk
%define repository gemdev
%define debug_package %{nil}
%define arch %(uname -m)
# $GIT_HASH is passed in by build_rpm.sh; git is only the fallback.
%define checkout %(if [ -n "$GIT_HASH" ]; then echo "$GIT_HASH"; else git rev-parse --short HEAD 2>/dev/null || echo nogit; fi)

#These global defines are added to prevent stripping
# symbols on vxWorks cross-compiled code
# Getting 'strip' to work is probably only needed for
# building a related debug sub-package
#
# But this prevents all the strip warnings
# mrippa 20120202
%global _enable_debug_package 0
%global debug_package %{nil}
%global __os_install_post /usr/lib/rpm/brp-compress %{nil}

Summary: %{name} Package, a module for EPICS base
Name: %{name}
Version: 1.1
Release: 2.git.%{checkout}%{?dist}
License: EPICS Open License
Group: Applications/Engineering
Source0: %{name}-%{version}.tar.gz
ExclusiveArch: %{arch}
Prefix: %{_prefix}
## You may specify dependencies here
# Pin every BuildRequires exactly with %{?dist} (rpm-repo is flat el8+el9;
# an unpinned dep can resolve to .el9 -- timeProbe-devel and tdct did in the
# first GitHub build). Values = what build 702da78 resolved, with the .el8
# build of the same NVR where it had picked .el9. asyn and streamdevice
# have no dist tag in rpm-repo, so they are pinned without %{?dist}.
BuildRequires: re2c                 = 0.14.3-2%{?dist}
BuildRequires: tdct                 = 2.18.6-5%{?dist}
BuildRequires: epics-base-devel     = 7.0.7-0.git.054b1d4%{?dist}
BuildRequires: sequencer-devel      = 2.2.9.e5e3615-4.git.33e0208%{?dist}
BuildRequires: geminiRec-devel      = 4.1.13-3.git.5dcd2db%{?dist}
BuildRequires: gemUtil-devel        = 1.6.13-2.git.cd2bab4%{?dist}
BuildRequires: pvload-devel         = 1.2.1-7.git.a70cb64%{?dist}
BuildRequires: timeProbe-devel      = 1.1.16-3.git.712092b%{?dist}
BuildRequires: wsSensors            = 1.1.1-7.git.51.8027bcf%{?dist}
BuildRequires: wsWeb                = 1.1.1-7.git.42.beb517a%{?dist}
BuildRequires: seeingMonitors-devel = 0.2-1.git.52.f85ddbc%{?dist}
BuildRequires: asyn-devel           = 4.44-1
BuildRequires: streamdevice-devel   = 2.8.22-0.git.8.181f91d
Requires: epics-base sequencer geminiRec gemUtil timeProbe pvload procServ conserver conserver-client wsSensors wsWeb seeingMonitors asyn streamdevice procServ-conserver
## Switch dependency checking off
AutoReqProv: no

%description
This is the %{name} soft IOC.

%package devel
Summary: Development files for %{name}
Group: Applications/Engineering
Requires: %{name} = %{version}-%{release}
Requires: epics-base-devel geminiRec-devel gemUtil-devel timeProbe-devel pvload-devel seeingMonitors-devel asyn-devel streamdevice-devel
AutoReqProv: no

%description devel
Development files for the %{name} module, including header files and libraries
needed for developing applications that use %{name}.

%prep
%setup -q 

%build
#update environment from former rpm installations due to BuildRequires
#source /gem_base/etc/profile
#start virtual framebuffer to have graphics for java
#Xvfb :1  -ac -nolisten tcp -nolisten unix &
source /gem_base/etc/profile
make distclean uninstall
make

%install
export DONT_STRIP=1
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/%{_prefix}/%{name}
cp -r db $RPM_BUILD_ROOT/%{_prefix}/%{name}
cp -r dbd $RPM_BUILD_ROOT/%{_prefix}/%{name}
cp -r data $RPM_BUILD_ROOT/%{_prefix}/%{name}
cp -r bin $RPM_BUILD_ROOT/%{_prefix}/%{name}
cp -r lib $RPM_BUILD_ROOT/%{_prefix}/%{name}
#cp -r include $RPM_BUILD_ROOT/%{_prefix}/%{name}
cp -r configure $RPM_BUILD_ROOT/%{_prefix}/%{name}
find $RPM_BUILD_ROOT/%{_prefix}/%{name}/configure -name ".git" -exec rm -rf {} \;

%post
# install service file and reload, disable the service
cp -f %{_prefix}/%{name}/data/procserv-%{name}.service /etc/systemd/system/
systemctl daemon-reload
systemctl disable procserv-%{name}.service

%preun
# disable and stop the service before uninstalling
systemctl disable procserv-%{name}.service
systemctl stop procserv-%{name}.service

%postun
# remove the service file and reload if not upgrading
if [ "$1" == "0" ]; then
    rm -f /etc/systemd/system/procserv-%{name}.service
    systemctl daemon-reload
fi

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root)
   /%{_prefix}/%{name}/bin
   /%{_prefix}/%{name}/db
   /%{_prefix}/%{name}/dbd
   /%{_prefix}/%{name}/lib
   /%{_prefix}/%{name}/configure
   /%{_prefix}/%{name}/data

%files devel
%defattr(-,root,root)

%changelog
* Mon Nov 02 2026 Hawi Stecher <hawi.stecher@noirlab.edu> - 1.1-2
- Moved from GitLab to GitHub gemini-rtsw-ci pipeline; git-hash release, pinned BuildRequires.
* Fri Jun 7 2024 Hawi Stecher <hawi.stecher@noirlab.edu>
- Enabled devel package with include files
* Fri Dec 27 2023 Anthony Sylvester <anthony.sylvester@noirlab.edu>
- Updated to match CP version added post, preun, postun steps
- Uncommented cp data directory
* Mon May 23 2022 Pedro Gigoux <pedro.gigoux@noirlab.edu>
- Updated version
* Mon May 16 2022 Pedro Gigoux <pedro.gigoux@noirlab.edu>
- Created specfile
