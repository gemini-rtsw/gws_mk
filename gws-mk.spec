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
Version: 1.0
Release: 1%{?dist}
License: EPICS Open License
Group: Applications/Engineering
Source0: %{name}-%{version}.tar.gz
ExclusiveArch: %{arch}
Prefix: %{_prefix}
## You may specify dependencies here
BuildRequires: epics-base-devel re2c tdct geminiRec-devel gemUtil-devel timeProbe-devel pvload-devel wsSensors wsWeb seeingMonitors-devel
Requires: epics-base sequencer geminiRec gemUtil timeProbe pvload procServ conserver conserver-client wsSensors wsWeb seeingMonitors
## Switch dependency checking off
AutoReqProv: no

%description
This is the %{name} soft IOC.

## If you want to have a devel-package to be generated uncomment the following:
#%package devel
#Summary: %{name}-devel Package
#Group: Development/Gemini
#Requires: %{name} tdct sequencer-devel bancomm-devel geminiRec-devel timelib-devel slalib-devel xycom-devel gemUtil-devel timeProbe-devel pvload-devel tcslib-devel astlib-devel tptlib-devel
#%description devel
#This is the module %{name}.

%prep
%setup -q 

%build
#update environment from former rpm installations due to BuildRequires
#source /gem_base/etc/profile
#start virtual framebuffer to have graphics for java
#Xvfb :1  -ac -nolisten tcp -nolisten unix &

make distclean uninstall
make

%install
export DONT_STRIP=1
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/%{_prefix}/%{name}
cp -r db $RPM_BUILD_ROOT/%{_prefix}/%{name}
cp -r dbd $RPM_BUILD_ROOT/%{_prefix}/%{name}
#cp -r data $RPM_BUILD_ROOT/%{_prefix}/%{name}
cp -r bin $RPM_BUILD_ROOT/%{_prefix}/%{name}
cp -r lib $RPM_BUILD_ROOT/%{_prefix}/%{name}
#cp -r include $RPM_BUILD_ROOT/%{_prefix}/%{name}
cp -r configure $RPM_BUILD_ROOT/%{_prefix}/%{name}
find $RPM_BUILD_ROOT/%{_prefix}/%{name}/configure -name ".git" -exec rm -rf {} \;

%post
source /etc/profile
# if upgrading, remove old systemd related files
if [ "$1" == "2" ]; then
    manage-procs remove -f %{name}

    # delete file copied in during installation
    rm -f /etc/systemd/system/procserv-%{name}.service

    manage-procs write-procs-cf
    systemctl daemon-reload
    systemctl restart conserver
fi

# install systemd files
manage-procs add -f -C /gem_base/epics/ioc/gws_mk \
    -e LD_LIBRARY_PATH=$LD_LIBRARY_PATH:%{_prefix}/%{name}/lib/linux-x86_64 \
    -Uroot -Groot %{name}  bin/linux-x86_64/stgws-mk-IOC.boot
if [ ! -d /etc/conserver ]; then mkdir /etc/conserver ; fi; manage-procs write-procs-cf

systemctl daemon-reload

# disable autostarting of service at boot / container start
systemctl disable procserv-%{name}.service
# copy the unit file from the unknown dir to the system's one
cp -f /etc/procServ.d/procserv-%{name}.service /etc/systemd/system/
systemctl daemon-reload
systemctl restart conserver

%postun
if [ "$1" == "0" ]; then
	manage-procs remove -f %{name}
        
    # delete file copied in during installation
    rm -f /etc/systemd/system/procserv-%{name}.service
    
	manage-procs write-procs-cf
	rm -rf %{_prefix}/%{name}
    systemctl daemon-reload
    systemctl restart conserver
fi


%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root)
   /%{_prefix}/%{name}/bin
   /%{_prefix}/%{name}/db
   /%{_prefix}/%{name}/dbd
   #/%{_prefix}/%{name}/data
   /%{_prefix}/%{name}/lib
   /%{_prefix}/%{name}/configure

#%files devel
#%defattr(-,root,root)
#  /%{_prefix}/%{name}/include

%changelog
* Mon May 16 2022 Pedro Gigoux <pedro.gigoux@noirlab.edu>
- Created specfile
