# Set the username and group name of the owner of the PHP code.
%define deployuser nginx
%define deployusergroup nginx

# Define the name of the RPM package
%define pkgname developmentstudio

Name:           %{pkgname}
Version:        0.1
Release:        %{_release}
Summary:        www.developmentstudio.nl

Group:          Applications/Internet
License:        Proprietary
URL:            http://www.developmentstudio.nl
Source0:        developmentstudio.zip
BuildRoot:      %{_tmppath}
BuildArch:      noarch

# Requires:       php70-common

%description
The developmentstudio.nl website.

%prep
%setup -n %{pkgname}
getent group %{deployusergroup} >/dev/null || groupadd %{deployusergroup}
getent passwd %{deployuser} >/dev/null || useradd -g %{deployusergroup} -M -s /sbin/nologin %{deployuser}
exit 0

%install
rm -rf $RPM_BUILD_ROOT
install -d $RPM_BUILD_ROOT%{_localstatedir}/www/developmentstudio.nl
install -d $RPM_BUILD_ROOT%{_localstatedir}/www/developmentstudio.nl/public
cp -a ./public/index.php $RPM_BUILD_ROOT%{_localstatedir}/www/developmentstudio.nl/public/index.php

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-, %{deployuser}, %{deployusergroup})
%{_localstatedir}/www/developmentstudio.nl

%changelog
* Mon Jul 10 2017 Kevin van Cleef <kevin@developmentstudio.nl> - 0.1-%{release}
- Initial package specification of development studio website.
