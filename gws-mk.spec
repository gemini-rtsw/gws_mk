%define _prefix /gem_base/epics/ioc
%define name gws_mk
%define repository gemdev
%define debug_package %{nil}
%define arch %(uname -m)
%define checkout %(git log --pretty=format:'%h' -n 1) 

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
Release: 1%{?dist}
License: EPICS Open License
Group: Applications/Engineering
Source0: %{name}-%{version}.tar.gz
ExclusiveArch: %{arch}
Prefix: %{_prefix}
## You may specify dependencies here
BuildRequires: epics-base-devel re2c tdct geminiRec-devel gemUtil-devel timeProbe-devel pvload-devel wsSensors wsWeb seeingMonitors-devel asyn-devel streamdevice-devel
Requires: epics-base sequencer geminiRec gemUtil timeProbe pvload procServ conserver conserver-client wsSensors wsWeb seeingMonitors asyn streamdevice procServ-conserver
## Switch dependency checking off
AutoReqProv: no

%description
This is the %{name} soft IOC.

%prep
%setup -q 

%build
#update environment from former rpm installations due to BuildRequires
#source /gem_base/etc/profile
#start virtual framebuffer to have graphics for java
#Xvfb :1  -ac -nolisten tcp -nolisten unix &
source /etc/profile
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

#%files devel
#%defattr(-,root,root)

%changelog
* Fri Dec 27 2024 Anthony Sylvester <anthony.sylvester@noirlab.edu>
- Updated to match CP version added post, preun, postun steps
* Mon May 23 2022 Pedro Gigoux <pedro.gigoux@noirlab.edu>
- Updated version
* Mon May 16 2022 Pedro Gigoux <pedro.gigoux@noirlab.edu>
- Created specfile
