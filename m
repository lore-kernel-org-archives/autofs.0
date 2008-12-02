From: "Paolo Minazzi" <paolo.minazzi@gmail.com>
Subject: Re: automount usb key (vfat and ntfs)
Date: Tue, 2 Dec 2008 08:52:52 +0100
Message-ID: <4aa525de0812012352n7f64051eqa3d28876bedb7fe1@mail.gmail.com>
References: <4aa525de0812010542k29530958r359ae01f1a514e58@mail.gmail.com>
	<x49tz9n96ao.fsf@segfault.boston.devel.redhat.com>
	<20081201193418.GT13650@eeg.ccf.org>
	<1228185613.2954.17.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1228185613.2954.17.camel@zeus.themaw.net>
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

Thanks Ian, Greg, Todd and Jeff for yout rime and suggestion.

I confirm that the script is

#!/bin/sh
if ntfs-3g.probe /dev/sda1; then
       echo "-fstype=ntfs-3g,other-opts :/dev/sda1"
else
       echo "-fstype=vfat,other-opts :/dev/sda1"
fi

On stdout we have to put the string "-fstype=fs,opts :/dev/XXX".

I have tried to use "fdisk -l" to identify the partition type.
This is an other way, but the program ntfs-3g is a better choice.

I don't have udev and hotplug.
Personally I don't like that stuff because it is complex.
In my opinion automount is perfect for my use.

In my opiniuon would be interesting if it was possible implement for
example a thing like "-fstype fs1,opts1;fs2,opts2;...,fsn,optsn" or
"-fstype fs1,opts1 -fstype fs2,opts2;...,-fstype fsn,optsn" in a file map.

This way don't need of a check program and would be more generic.

Thanks again to Ian, Greg, Todd and Jeff.
I liked to implement this in the right way, not in a dirty way. Now I
have the right idea.

Bye,
Paolo
