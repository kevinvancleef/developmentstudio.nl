#!/usr/bin/env bash

yum clean all
yum -y update
yum -y install rpm-build make tree

mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}

zip -r developmentstudio.zip /developmentstudio

mv developmentstudio.zip ~/rpmbuild/SOURCES/
cp /developmentstudio/developmentstudio.spec ~/rpmbuild/SPECS/

rpmbuild -ba ~/rpmbuild/SPECS/developmentstudio.spec --define "_release $1"

cp -r ~/rpmbuild/SRPMS /developmentstudio/rpms
cp -r ~/rpmbuild/RPMS /developmentstudio/rpms
