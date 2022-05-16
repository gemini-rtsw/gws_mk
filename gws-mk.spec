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
Version: 2.9
Release: 22%{?dist}
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
    -Uroot -Groot %{name}  bin/linux-x86_64/sttcs-cp-ioc.boot
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
* Tue Mar 22 2022 Matt Rippa <matt.rippa@noirlab.edu> 2.9-22
- Updated specfile build and runtime dependencies

* Tue Mar 22 2022 Matt Rippa <matt.rippa@noirlab.edu> 2.9-21
- new package built with tito

* Tue Mar 22 2022 Matt Rippa <matt.rippa@noirlab.edu>
- New ADE2 team build. Merging latest from GS FastTrack
- IA: Snapshot commit of softTCS 20220322
- startup file adjustment
- test version
- updated EPICS_CA_ADDR_LIST env variable
- TCS top set to tc1:
- Changed gem-ci to stable/2021q4 branch
- Forcing unstable epics base release
- Forcing the pipeline to build the softTCS_CP image
- Fist tcs_cp
- First TCS_CP unstable
- First buils for unstable release CP
- building to unstable/2021q4

* Tue Mar 22 2022 Matt Rippa <matt.rippa@noirlab.edu>
- New ADE2 team build. Merging latest from GS FastTrack
- IA: Snapshot commit of softTCS 20220322
- startup file adjustment
- test version
- updated EPICS_CA_ADDR_LIST env variable
- TCS top set to tc1:
- Changed gem-ci to stable/2021q4 branch
- Forcing unstable epics base release
- Forcing the pipeline to build the softTCS_CP image
- Fist tcs_cp
- First TCS_CP unstable
- First buils for unstable release CP

* Tue Apr 06 2021 Roberto Rojas <rrojas@gemini.edu> 2.9-18
- Removes not existing GEMS/ECS  records
- Removed not existing channels
- Removed channels not connected
- oiwfs missed channels
- Remove OIWFS probe unexisting channels
- Fixed my mistake of not changing mk to cp
- Changed spec file to include procServ management

* Mon Mar 15 2021 Tim Gaggstatter <tim.gaggstatter@noirlab.edu> 2.9-17
- Changed EPICS_CA_ADDR_LIST

* Mon Feb 15 2021 Tim Gaggstatter <tim.gaggstatter@noirlab.edu> 2.9-16
- For some files we need to shorten the path to configuration files, changing
  from rtconfig to rt
- Testing communication performance with timeAudit
- Passing down dynamic configuration directory to C code to be used on M1 model
  files

* Thu Jan 21 2021 Tim Gaggstatter <tim.gaggstatter@noirlab.edu> 2.9-15
- Hardcoded path to gem_sw, fixed just for testing

* Wed Jan 20 2021 Roberto Rojas <rrojas@gemini.edu> 2.9-14
- tcs top defined and use relative path

* Fri Jan 15 2021 Roberto Rojas <rrojas@gemini.edu> 2.9-13
- REL-3897 S_por_ob in tcsPointing.c was writing am array out-of-limits
  position

* Mon Jan 11 2021 Roberto Rojas <rrojas@gemini.edu> 2.9-11
- 

* Wed Jan 06 2021 Roberto Rojas <rrojas@gemini.edu> 2.9-10
- added installation directories

* Tue Jan 05 2021 Roberto Rojas <rrojas@gemini.edu> 2.9-9
- pmaclib removed

* Mon Jan 04 2021 Roberto Rojas <rrojas@gemini.edu> 2.9-8
- removed astlib.dbd file

* Wed Dec 23 2020 Roberto Rojas <rrojas@gemini.edu> 2.9-7
- new package built with tito

* Wed Dec 23 2020 Roberto Rojas <rrojas@gemini.edu>
- new package built with tito

* Tue Oct 27 2020 fkraemer <fkraemer@gemini.edu> 2.9-5
- some small (automated) adjustments
- deleted some unneccesssary lines in configure/RELEASE
- adjustments for local testing installation to
  /gem_base/${USER}/${PROJECTNAME} using the EPICS build framework

* Tue Oct 20 2020 Matt Rippa <mrippa@gemini.edu> 2.9-4
- test2 startup script

* Tue Oct 20 2020 Matt Rippa <mrippa@gemini.edu> 2.9-3
- test startup script

* Fri Oct 09 2020 fkraemer <fkraemer@gemini.edu> 2.9-2
- applied new version/release scheme and new yum repository structure

* Sun Sep 20 2020 fkraemer <fkraemer@gemini.edu> 3.15.8-2.9.2020092010021f3ee2b
- reverted back temporary changes install to other path in boot file, do the cd
  in bootup scripts relative (fkraemer@gemini.edu)
- commented out everything for testing purposes in boot file
  (fkraemer@gemini.edu)
- Changed references from support modules to *Supp.dbd files
  (iarriagada@gemini.edu)
- - switch automatic dependency checking off - add %%H%%M to date format string
  in release tag to have that in RPM name, too A(for rebuilds of the package at
  the same day) (fkraemer@gemini.edu)

* Sun Aug 02 2020 fkraemer <fkraemer@gemini.edu> 3.15.8-2.9.20200802a6a87f2
- crcs-cp-ioc -> crcs-mk-ioc (fkraemer@gemini.edu)

* Wed Jul 29 2020 fkraemer <fkraemer@gemini.edu> 3.15.8-2.9.20200729010f18c
- removed to copy non-existen lib directory from specfile (fkraemer@gemini.edu)
- Moved local getTime() to crcsGetTime() to avoid clash with getTime() from
  timeProbe. (mrippa@gemini.edu)
- Moved local getTime() to crcsGetTime() to avoid clash with getTime() from
  timeProbe. (mrippa@gemini.edu)
- Migrated tsDef timestamps to epicsTime in the logData.c (mrippa@gemini.edu)
- added menuScan.dbd because of errors and this thread in techtalk:
  https://epics.anl.gov/tech-talk/2020/msg00040.php (fkraemer@gemini.edu)
- replace iocstats with iocStats in specfile (fkraemer@gemini.edu)

* Wed Jul 29 2020 fkraemer <fkraemer@gemini.edu> 3.15.8-2.9.20200729067a20f
- fixed configure/RELEASE (fkraemer@gemini.edu)
- adjusted crcs_mk-devel deps (fkraemer@gemini.edu)

* Wed Jul 29 2020 fkraemer <fkraemer@gemini.edu> 3.15.8-2.9.2020072994b1d6f
- new package built with tito

