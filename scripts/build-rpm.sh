#!/usr/bin/env bash

yum clean all
yum -y update
yum -y install rpm-build make createrepo tree

mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}

zip -r developmentstudio.zip /developmentstudio

mv developmentstudio.zip ~/rpmbuild/SOURCES/
cp /developmentstudio/developmentstudio.spec ~/rpmbuild/SPECS/

rpmbuild -ba ~/rpmbuild/SPECS/developmentstudio.spec --define "_release $1"

[ -d /developmentstudio/build ] || mkdir /developmentstudio/build
[ -d /developmentstudio/build/source-packages ] || mkdir /developmentstudio/build/source-packages
[ -d /developmentstudio/build/source-packages/$2 ] || mkdir /developmentstudio/build/source-packages/$2
[ -d /developmentstudio/build/source-packages/$2/$3 ] || mkdir /developmentstudio/build/source-packages/$2/$3
[ -d /developmentstudio/build/$2 ] || mkdir /developmentstudio/build/$2
[ -d /developmentstudio/build/$2/$3 ] || mkdir /developmentstudio/build/$2/$3
[ -d /developmentstudio/build/$2/$3/no-arch ] || mkdir /developmentstudio/build/$2/$3/no-arch

for a in ~/rpmbuild/RPMS/noarch ; do createrepo -v --deltas $a/ ; done

cp -r ~/rpmbuild/SRPMS/* /developmentstudio/build/source-packages/$2/$3
cp -r ~/rpmbuild/RPMS/noarch/* /developmentstudio/build/$2/$3/no-arch
